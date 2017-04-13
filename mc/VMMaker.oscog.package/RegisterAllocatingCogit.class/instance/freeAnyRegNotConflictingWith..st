simulation stack
freeAnyRegNotConflictingWith: regMask
	"Spill the closest register on stack not conflicting with regMask. 
	 Override to unassign assigned temp regs if necessary."
	<var: #desc type: #'CogSimStackEntry *'>
	| index desc |
	self assert: needsFrame.
	index := simSpillBase max: 0.
	[index < simStackPtr] whileTrue: 
		[desc := self simStackAt: index.
		 desc type = SSRegister ifTrue:
			[(regMask anyMask: (self registerMaskFor: desc register)) ifFalse: 
				[self ssAllocateRequiredReg: desc register.
				 ^desc register]].
		 index := index + 1].
	0 to: methodOrBlockNumTemps - 1 do:
		[:i|
		 desc := self simStackAt: i.
		 (desc liveRegister = NoReg
		 or: [self register: desc liveRegister isInMask: regMask]) ifFalse:
			[self ssAllocateRequiredReg: desc liveRegister.
			 ^desc liveRegister]].
	^NoReg