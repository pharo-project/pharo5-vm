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
	opcodeIndex := 0.
	self CmpCq: 0 R: ReceiverResultReg.
	jumpSICMiss := self JumpNonZero: 0.
	"on machines with a link register, pop the stack if the ReceiverResultReg = 0,
	 i.e. if coming through the stack check abort; frame build has already pushed it."
	backEnd hasLinkRegister ifTrue:
		[self AddCq: BytesPerWord R: SPReg].

	self compileTrampolineFor: #ceStackOverflow:
		numArgs: 1
		arg: SendNumArgsReg
		arg: nil
		arg: nil
		arg: nil
		saveRegs: false
		pushLinkReg: true
		resultReg: nil.
	jumpSICMiss jmpTarget: self Label.
	^self genTrampolineFor: #ceSICMiss:
		called: 'ceMethodAbort'
		numArgs: 1
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		arg: nil
		saveRegs: false
		pushLinkReg: true
		resultReg: nil
		appendOpcodes: true