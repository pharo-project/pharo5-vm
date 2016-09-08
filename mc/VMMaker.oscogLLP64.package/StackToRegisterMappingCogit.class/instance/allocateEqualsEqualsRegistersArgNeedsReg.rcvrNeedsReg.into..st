bytecode generator support
allocateEqualsEqualsRegistersArgNeedsReg: argNeedsReg rcvrNeedsReg: rcvrNeedsReg into: binaryBlock
	<inline: true>
	| argReg rcvrReg |
	self assert: (argNeedsReg or: [rcvrNeedsReg]).
	argReg := rcvrReg := NoReg.
	argNeedsReg
		ifTrue: 
			[rcvrNeedsReg
				ifTrue:
					[self allocateRegForStackTopTwoEntriesInto: [:rTop :rNext| argReg := rTop. rcvrReg := rNext].
					 self ssTop popToReg: argReg.
					 (self ssValue: 1) popToReg: rcvrReg]
				ifFalse:
					[argReg := self allocateRegForStackEntryAt: 0.
					 self ssTop popToReg: argReg.
					 "If the receiver is a spilled constant we need to pop it from the stack."
					 (self ssValue: 1) spilled ifTrue:
						[self AddCq: objectMemory wordSize R: SPReg]]]
		ifFalse:
			[self assert: rcvrNeedsReg.
			 self deny: self ssTop spilled.
			 rcvrReg := self allocateRegForStackEntryAt: 1.
			 (self ssValue: 1) popToReg: rcvrReg].
		
	self deny: (argNeedsReg and: [argReg = NoReg]).
	self deny: (rcvrNeedsReg and: [rcvrReg = NoReg]).

	binaryBlock value: rcvrReg value: argReg