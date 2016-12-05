bytecode generator support
reconcileRegisterStateForJoinAfterSpecialSelectorSend
	"When the control flow from the inlined special selector code (e.g. add or comparison)
	 joins the control flow from the send, taken when the inlined code fails, we should decide
	 whether to reload any registers known to contain useful values or mark them as dead."
	 
	"If ReceiverResultReg is live along the inlined path, and is used before the next full send,
	 reload it on the uncommon path."
	scratchOptStatus isReceiverResultRegLive ifTrue:
		[(self existsInstVarRefBeforeSendOrReturn
		  or: [self receiverRefOnScratchSimStack])
			ifTrue:
				[optStatus isReceiverResultRegLive: true.
				 optStatus ssEntry storeToReg: ReceiverResultReg]
			ifFalse: [self voidReceiverOptStatus]].

	"Restore the simStack to that in scratchSimStack,
	 popping any spilled state back into allocated registers."
	simSpillBase := scratchSpillBase.
	simStackPtr to: 0 by: -1 do:
		[:i|
		 self assert: (i = simStackPtr
						ifTrue: [(self simStackAt: i) type = SSRegister]
						ifFalse: [(self simStackAt: i) spilled]).
		 (self simStackAt: i) reconcilePoppingWith: (self simStack: scratchSimStack at: i).
		 simStack
			at: i
			put: (self
					cCode: [scratchSimStack at: i]
					inSmalltalk: [(scratchSimStack at: i) copy])]