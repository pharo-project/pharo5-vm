simulation stack
freeAnyRegNotConflictingWith: regMask
	"Spill the closest register on stack not conflicting with regMask. 
	 Override so no assertion failure if no register can be allocated."
	<var: #desc type: #'CogSimStackEntry *'>
	| reg index |
	self assert: needsFrame.
	reg := NoReg.
	index := simSpillBase max: 0.
	[reg = NoReg and: [index < simStackPtr]] whileTrue: 
		[ | desc |
		 desc := self simStackAt: index.
		 desc type = SSRegister ifTrue:
			[(regMask anyMask: (self registerMaskFor: desc register)) ifFalse: 
				[reg := desc register]].
		 index := index + 1].
	reg ~= NoReg ifTrue:
		[self ssAllocateRequiredReg: reg].
	^reg