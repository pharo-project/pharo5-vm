simulation stack
allocateRegNotConflictingWith: regMask
	| reg |
	"if there's a free register, use it"
	reg := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: regMask).
	reg = NoReg ifTrue: "No free register, choose one that does not conflict with regMask"
		[reg := self freeAnyRegNotConflictingWith: regMask].
	reg = ReceiverResultReg ifTrue: "If we've allocated RcvrResultReg, it's not live anymore"
		[self voidReceiverResultRegContainsSelf].
	^ reg