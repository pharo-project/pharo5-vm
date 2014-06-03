simulation stack
merge: fixup afterContinuation: mergeWithContinuation
	"Merge control flow at a fixup.  The fixup holds the simStackPtr at the jump to this target.
	 See stackToRegisterMapping on the class side for a full description."
	<var: #fixup type: #'BytecodeFixup *'>
	self traceMerge: fixup.
	"For now we don't try and preserve the optimization status through merges."
	optStatus isReceiverResultRegLive: false.
	"If this instruction follows a return or an unconditional branch then the
	 current simStackPtr is irrelevant and we continue with that of the fixup."
	mergeWithContinuation ifFalse:
		[self assert: fixup targetInstruction asUnsignedInteger >= 2.  "Must have a valid simStackPtr"
		 simStackPtr := fixup simStackPtr].
	fixup targetInstruction asUnsignedInteger <= 2 ifTrue:
		["This is either a forward or backward branch target.
		  The stack must be flushed."
		 self ssFlushTo: simStackPtr.
		 fixup simStackPtr <= -2 ifTrue:
			"This is the target of a backward branch.  It doesn't have a simStackPtr yet."
			[fixup simStackPtr: simStackPtr].
		 fixup targetInstruction: self Label].
	self assert: simStackPtr >= fixup simStackPtr.
	self cCode: '' inSmalltalk:
		[self assert: fixup simStackPtr = (self debugStackPointerFor: bytecodePC)].
	simStackPtr := fixup simStackPtr.
	simSpillBase := methodOrBlockNumTemps.
	"For now throw away all type information for values on the stack, but sometime consider
	 the more sophisticated merge described in the class side stackToRegisterMapping."
	methodOrBlockNumTemps to: simStackPtr do:
		[:i|
		(self simStackAt: i)
			mergeAt: FoxMFReceiver - (i - methodOrBlockNumArgs + 1 * BytesPerOop)
			from: FPReg]