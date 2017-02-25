compile abstract instructions
compileFrameBuild
	"Build a frame for a CogMethod activation.  See CoInterpreter class>>initializeFrameIndices.
	 		receiver (in ReceiverResultReg)
			arg0
			...
			argN
			caller's saved ip/this stackPage (for a base frame)
	fp->	saved fp
			method
			context (uninitialized?)
			receiver
			first temp
			...
	sp->	Nth temp
	If there is a primitive and an error code the Nth temp is the error code.
	Ensure SendNumArgsReg is set early on (incidentally to nilObj) because
	it is the flag determining whether context switch is allowed on stack-overflow."
	| jumpSkip |
	<inline: false>
	<var: #jumpSkip type: #'AbstractInstruction *'>
	needsFrame ifFalse: [^self].
	backEnd hasLinkRegister ifTrue: [self PushR: LinkReg].
	self PushR: FPReg.
	self MoveR: SPReg R: FPReg.
	methodLabel addDependent: (self annotateAbsolutePCRef:
		(self PushCw: methodLabel asInteger)). "method"
	self genMoveNilR: SendNumArgsReg.
	self PushR: SendNumArgsReg. "context"
	self PushR: ReceiverResultReg.
	methodOrBlockNumArgs + 1 to: (coInterpreter temporaryCountOfMethodHeader: methodHeader) do:
		[:i|
		self PushR: SendNumArgsReg].
	(self methodUsesPrimitiveErrorCode: methodObj header: methodHeader) ifTrue:
		[self compileGetErrorCode].
	self MoveAw: coInterpreter stackLimitAddress R: TempReg.
	self CmpR: TempReg R: SPReg. "N.B. FLAGS := SPReg - TempReg"
	"If we can't context switch for this method, use a slightly
	 slower overflow check that clears SendNumArgsReg."
	(coInterpreter canContextSwitchIfActivating: methodObj header: methodHeader)
		ifTrue:
			[self JumpBelow: stackOverflowCall.
			 stackCheckLabel := self Label]
		ifFalse:
			[jumpSkip := self JumpAboveOrEqual: 0.
			 self MoveCq: 0 R: SendNumArgsReg.
			 self Jump: stackOverflowCall.
			 jumpSkip jmpTarget: (stackCheckLabel := self Label)].
	self annotateBytecode: stackCheckLabel.
	NewspeakVM ifTrue:
		[numIRCs > 0 ifTrue:
		 	[self PrefetchAw: theIRCs]]