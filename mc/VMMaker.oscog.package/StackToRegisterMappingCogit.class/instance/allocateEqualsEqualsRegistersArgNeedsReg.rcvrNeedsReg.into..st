bytecode generator support
allocateEqualsEqualsRegistersArgNeedsReg: argNeedsReg rcvrNeedsReg: rcvrNeedsReg into: binaryBlock
	<inline: true>
	| argReg rcvrReg |
	self assert: (argNeedsReg or: [rcvrNeedsReg]).
	argNeedsReg
		ifTrue: 
			[rcvrNeedsReg
				ifTrue:
					[self allocateRegForStackTopTwoEntriesInto: [:rTop :rNext| argReg := rTop. rcvrReg := rNext].
					 self ssTop popToReg: argReg.
					 (self ssValue: 1) popToReg: rcvrReg]
				ifFalse:
					[argReg := self allocateRegForStackTopEntry.
					 self ssTop popToReg: argReg]]
		ifFalse:
			[self assert: rcvrNeedsReg.
			rcvrReg := self allocateRegForStackEntryAt: 1.
			(self ssValue:1) popToReg: rcvrReg].
		
	self assert: (argNeedsReg not or: [argReg notNil]).
	self assert: (rcvrNeedsReg not or: [rcvrReg notNil]).
	
	binaryBlock value: rcvrReg value: argReg.