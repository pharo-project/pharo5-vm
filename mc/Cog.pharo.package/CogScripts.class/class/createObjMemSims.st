separate vm scripts
createObjMemSims
	"self createObjMemSims"
	{ NewObjectMemory. NewCoObjectMemory } do:
		[:c| | sc oc nc |
		sc := Compiler evaluate: ((Class templateForSubclassOf: c category: c category, 'Simulation') copyReplaceAll: 'NameOfSubclass' with: c name, 'Simulator').
		false ifTrue:
			[oc := NewObjectMemorySimulator.
			oc selectors do:
				[:s| [sc compile: (oc sourceCodeAt: s) asString
						classified: (oc whichCategoryIncludesSelector: s)
						withStamp: (oc >> s) timeStamp
						notifying: nil] on: Error do: [:ex|]]].
		nc := Compiler evaluate: ((Class templateForSubclassOf: sc category: sc category) copyReplaceAll: 'NameOfSubclass' with: sc name, 'LSB').
		oc := nc selectors size > 0 ifTrue: [nc] ifFalse: [NewObjectMemorySimulatorLSB].
		oc selectors do:
			[:s| | aoc |
			aoc := (CogVMSimulatorLSB includesSelector: s) ifTrue: [CogVMSimulatorLSB] ifFalse: [NewObjectMemorySimulatorLSB].
			nc compile: (aoc sourceCodeAt: s) asString
					classified: (aoc whichCategoryIncludesSelector: s)
					withStamp: (aoc >> s) timeStamp
					notifying: nil].
		nc := Compiler evaluate: ((Class templateForSubclassOf: sc category: sc category) copyReplaceAll: 'NameOfSubclass' with: sc name, 'MSB').
		oc := NewObjectMemorySimulatorMSB.
		oc selectors do:
			[:s| nc compile: (oc sourceCodeAt: s) asString
					classified: (oc whichCategoryIncludesSelector: s)
					withStamp: (oc >> s) timeStamp
					notifying: nil]]