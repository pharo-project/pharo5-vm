debugging
duplicateRegisterAssignmentsInTemporaries
	| liveRegisters |
	liveRegisters := 0.
	0 to: methodOrBlockNumTemps - 1 do:
		[:i| | liveRegister |
		liveRegister := (self simStackAt: i) liveRegister.
		liveRegister ~= NoReg ifTrue:
			[(self register: liveRegister isInMask: liveRegisters) ifTrue:
				[^true].
			 liveRegisters := liveRegisters bitOr: 1 << liveRegister]].
	^false