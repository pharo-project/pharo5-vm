simulation stack
allocateRegisterNotConflictingWith: registerMask
	| reg |
	"if there's a free register, use it"
	reg := backEnd availableRegisterOrNilFor: (self liveRegisters bitOr: registerMask).
	reg ifNil: "No free register, choose one that does not conflict with registerMask"
		[reg := self freeRegisterNotConflictingWith: registerMask].
	reg = ReceiverResultReg ifTrue: "If we've allocated RcvrResultReg, it's not live anymore"
		[ optStatus isReceiverResultRegLive: false ].
	^ reg