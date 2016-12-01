bytecode generator support
receiverRefOnScratchSimStack
	simStackPtr to: (0 max: scratchSpillBase) by: -1 do:
		[:i|
		 ((self simStack: scratchSimStack at: i) register = ReceiverResultReg
		  and: [(self simStack: scratchSimStack at: i) type = SSBaseOffset]) ifTrue:
			[^true]].
	^false