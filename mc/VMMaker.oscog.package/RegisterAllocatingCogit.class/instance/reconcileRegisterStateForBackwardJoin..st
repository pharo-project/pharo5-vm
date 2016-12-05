bytecode generator support
reconcileRegisterStateForBackwardJoin: fixup 
	<var: #fixup type: #'SSBytecodeFixup *'>
	| fixupSimStack |
	<var: #fixupSimStack type: #'SimStackEntry *'>
	self assert: (optStatus ssEntry isSameEntryAs: simSelf). 
	fixup isReceiverResultRegSelf ifTrue:
		[optStatus isReceiverResultRegLive ifFalse:
			[optStatus ssEntry storeToReg: ReceiverResultReg]].
	fixupSimStack := fixup mergeSimStack.
	simStackPtr to: 0 by: -1 do:
		[:i|
		 self assert: (self simStackAt: i) spilled.
		 (self simStackAt: i) reconcileBackwardsWith: (fixupSimStack at: i)]