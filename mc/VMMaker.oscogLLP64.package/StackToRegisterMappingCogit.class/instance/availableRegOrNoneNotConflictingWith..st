simulation stack
availableRegOrNoneNotConflictingWith: regMask
	<inline: true>
	"If there's a free register, answer it, otherwise answer NoReg."
	^backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: regMask)