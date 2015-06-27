simulation stack
availableRegNotConflictingWith: regMask
	<inline: true>
	"If there's a free register, answer it, otherwise answer nil."
	^backEnd availableRegisterOrNilFor: (self liveRegisters bitOr: regMask)