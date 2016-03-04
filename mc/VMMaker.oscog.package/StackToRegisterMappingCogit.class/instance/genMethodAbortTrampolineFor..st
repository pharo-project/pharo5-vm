initialization
genMethodAbortTrampolineFor: numArgs
	"Generate the abort for a method.  This abort performs either a call of ceSICMiss:
	 to handle a single-in-line cache miss or a call of ceStackOverflow: to handle a
	 stack overflow.  It distinguishes the two by testing ResultReceiverReg.  If the
	 register is zero then this is a stack-overflow because a) the receiver has already
	 been pushed and so can be set to zero before calling the abort, and b) the
	 receiver must always contain an object (and hence be non-zero) on SIC miss."
	| jumpSICMiss |
	<var: #jumpSICMiss type: #'AbstractInstruction *'>
	self zeroOpcodeIndex.
	self CmpCq: 0 R: ReceiverResultReg.
	jumpSICMiss := self JumpNonZero: 0.

	"The abort sequence has pushed the LinkReg a second time - because a stack
	 overflow can only happen after building a frame, which pushes LinkReg anyway, and
	 we still need to push LinkReg in case we get to this routine from a sendMissAbort.
	 (On ARM there is a simpler way; use two separate abort calls since all instructions are 32-bits
	  but on x86 the zero receiver reg, call methodAbort sequence is smaller; we may fix this one day).
	 Overwrite that duplicate with the right one - the return address for the call to the abort trampoline.
	 The only reason it matters is an assert in ceStackOverflow: uses it"
	backEnd hasLinkRegister ifTrue:
		[self MoveR: LinkReg Mw: 0 r: SPReg].
	self compileTrampolineFor: #ceStackOverflow:
		numArgs: 1
		arg: SendNumArgsReg
		arg: nil
		arg: nil
		arg: nil
		regsToSave: self emptyRegisterMask
		pushLinkReg: false "The LinkReg has already been set above."
		resultReg: NoReg.
	jumpSICMiss jmpTarget: self Label.
	backEnd genPushRegisterArgsForAbortMissNumArgs: numArgs.
	^self genTrampolineFor: #ceSICMiss:
		called: (self trampolineName: 'ceMethodAbort' numRegArgs: numArgs)
		numArgs: 1
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		arg: nil
		regsToSave: self emptyRegisterMask
		pushLinkReg: false "The LinkReg will have been pushed in genPushRegisterArgsForAbortMissNumArgs: above."
		resultReg: NoReg
		appendOpcodes: true