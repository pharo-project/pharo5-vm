bytecode generator support
simSelfOnStackInReceiverResultReg
	"For assert checking only."
	methodOrBlockNumArgs to: simStackPtr do:
		[:i|
		 (((self addressOf: simSelf) isSameEntryAs: (self simStackAt: i))
		  and: [(self simStackAt: i) registerOrNone = ReceiverResultReg]) ifTrue:
			[^true]].
	^false