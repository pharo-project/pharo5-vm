simulation stack
allocateFloatRegNotConflictingWith: regMask
	| reg |
	"if there's a free register, use it"
	reg := backEnd availableFloatRegisterOrNoneFor: (self liveFloatRegisters bitOr: regMask).
	reg = NoReg ifTrue: "No free register, choose one that does not conflict with regMask"
		[reg := self freeAnyFloatRegNotConflictingWith: regMask].
	^ reg