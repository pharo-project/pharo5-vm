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
	opcodeIndex := 0.
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
		saveRegs: false
		pushLinkReg: false "The LinkReg has already been set above."
		resultReg: nil.
	jumpSICMiss jmpTarget: self Label.
	backEnd genPushRegisterArgsForAbortMissNumArgs: numArgs.
	^self genTrampolineFor: #ceSICMiss:
		called: (self trampolineName: 'ceMethodAbort' numArgs: (numArgs <= self numRegArgs ifTrue: [numArgs] ifFalse: [-1]))
		numArgs: 1
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		arg: nil
		saveRegs: false
		pushLinkReg: false "The LinkReg will have been pushed in genPushRegisterArgsForAbortMissNumArgs: above."
		resultReg: nil
		appendOpcodes: true