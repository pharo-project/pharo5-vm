simulation stack
allocateRegForStackEntryAt: index
	"If the stack entry is already in a register, answers it,
	else allocate a new register for it"
	<inline: true>
	| reg |
	(reg := (self ssValue: index) registerOrNone) ~= NoReg ifTrue:
		[^reg].
	^self allocateRegForStackEntryAt: index notConflictingWith: (self liveRegisters bitOr: (self registerMaskFor: FPReg and: SPReg and: TempReg))