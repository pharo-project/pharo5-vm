simulation stack
ssStorePop: popBoolean toPreferredReg: preferredReg
	"Store or pop the top simulated stack entry to a register.
	 Use preferredReg if the entry is not itself a register.
	 Answer the actual register the result ends up in."
	| actualReg liveRegisters |
	actualReg := preferredReg.
	self ssTop type = SSRegister ifTrue: 
		[self assert: (self ssTop liveRegister = NoReg
					  or: [self ssTop liveRegister = self ssTop register]).
		self assert: self ssTop spilled not.
		actualReg := self ssTop register].
	self ssTop liveRegister ~= NoReg ifTrue:
		[actualReg := self ssTop liveRegister].
	liveRegisters := self liveRegistersExceptingTopNItems: 1 in: simStack.
	(self register: actualReg isInMask: liveRegisters) ifTrue:
		[actualReg := self allocateRegNotConflictingWith: (self registerMaskFor: preferredReg).
		 actualReg = NoReg ifTrue:
			[actualReg := preferredReg]].
	self deny: (self register: actualReg isInMask: liveRegisters).
	self ssStorePop: popBoolean toReg: actualReg. "generates nothing if ssTop is already in actualReg"
	^actualReg