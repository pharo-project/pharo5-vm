tests
testPCMappingSelect: aBlock options: optionsDictionaryOrArray
	"Test pc mapping both ways using a selection of the methods in the current image."
	| n cogit coInterpreter |
	cogit := self instanceForTests: optionsDictionaryOrArray.
	coInterpreter := CurrentImageCoInterpreterFacade forCogit: cogit.
	[cogit
			setInterpreter: coInterpreter;
			singleStep: true;
			initializeCodeZoneFrom: 1024 upTo: coInterpreter memory size]
		on: Notification
		do: [:ex|
			(ex messageText beginsWith: 'cannot find receiver for') ifTrue:
				[ex resume: coInterpreter]].
	n := -1.
	SystemNavigation new allSelect:
		[:m| | cm |
		(m isQuick not
		 and: [aBlock value: m]) ifTrue:
			[(n := n + 1) \\ 10 = 0 ifTrue: [Transcript nextPut: $.; flush].
			 cm := cogit
						cog: (coInterpreter oopForObject: m)
						selector: (coInterpreter oopForObject: m selector).
			  cm ifNil:
				[cogit methodZone clearCogCompiledCode.
				 coInterpreter initializeObjectMap.
				 cm := cogit
							cog: (coInterpreter oopForObject: m)
							selector: (coInterpreter oopForObject: m selector).
				cm ifNil: [Transcript show: 'After 1 Cog compiled code compaction, still not able to generate the cog method...' ] ].
			  cm ifNotNil:
				[cogit testPCMappingForCompiledMethod: m cogMethod: cm]].
		 false] 