simulation stack
allocateRegPreferringCalleeSavedNotConflictingWith: regMask
	"If there are multiple free registers, choose one which is callee saved,
	else just allocate a register not conflicting with regMask"
	| reg |
	reg := backEnd availableRegisterOrNilFor: ((self liveRegisters bitOr: regMask) bitOr: callerSavedRegMask).
	^ reg
		ifNil: [ self allocateRegNotConflictingWith: regMask ]
		ifNotNil: [ reg ]