bytecode generator support
receiverRefOnScratchSimStack
	simStackPtr to: (0 max: scratchSpillBase) by: -1 do:
		[:i|
		 ((self addressOf: (scratchSimStack at: i)) register = ReceiverResultReg
		  and: [(self addressOf: (scratchSimStack at: i)) type = SSBaseOffset]) ifTrue:
			[^true]].
	^false