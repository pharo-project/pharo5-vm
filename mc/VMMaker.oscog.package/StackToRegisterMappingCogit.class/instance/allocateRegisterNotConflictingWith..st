simulation stack
allocateRegisterNotConflictingWith: regMask
	| reg |
	"if there's a free register, use it"
	reg := backEnd availableRegisterOrNilFor: (self liveRegisters bitOr: regMask).
	reg ifNil: "No free register, choose one that does not conflict with regMask"
		[reg := self freeRegisterNotConflictingWith: regMask].
	reg = ReceiverResultReg ifTrue: "If we've allocated RcvrResultReg, it's not live anymore"
		[ optStatus isReceiverResultRegLive: false ].
	^ reg