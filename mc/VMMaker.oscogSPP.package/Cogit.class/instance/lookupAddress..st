disassembly
lookupAddress: address
	<doNotGenerate>
	| cogMethod |
	address < methodZone freeStart ifTrue:
		[address >= methodZoneBase
			ifTrue:
				[(cogMethod := methodZone methodFor: address) ~= 0 ifTrue:
					[cogMethod := self cCoerceSimple: cogMethod to: #'CogMethod *'.
					 ^((cogMethod selector ~= objectMemory nilObject
					    and: [objectRepresentation couldBeObject: cogMethod selector])
						ifTrue: [coInterpreter stringOf: cogMethod selector]
						ifFalse: [cogMethod asInteger hex]),
					   '@', ((address - cogMethod asInteger) hex allButFirst: 3)]]
			ifFalse:
				[^address = (self codeEntryFor: address) ifTrue:
					[self codeEntryNameFor: address]].
		 ^nil].
	(simulatedTrampolines includesKey: address) ifTrue:
		[^self labelForSimulationAccessor: (simulatedTrampolines at: address)].
	(simulatedVariableGetters includesKey: address) ifTrue:
		[^self labelForSimulationAccessor: (simulatedVariableGetters at: address)].
	^coInterpreter lookupAddress: address