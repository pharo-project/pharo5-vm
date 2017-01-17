initialization
genMethodAbortTrampoline
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

	"The abort sequencer has pushed the LinkReg a second time.
	 Overwrite it with the right one."
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
	^self genTrampolineFor: #ceSICMiss:
		called: 'ceMethodAbort'
		numArgs: 1
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		arg: nil
		regsToSave: self emptyRegisterMask
		pushLinkReg: true "Push the LinkReg for the ceMethodAbort call."
		resultReg: NoReg
		appendOpcodes: true