compile abstract instructions
compileFullBlockMethodFrameBuild: numCopied
	"Build a frame for a block activation.  See CoInterpreter class>>initializeFrameIndices.
	 		closure (in ReceiverResultReg)
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
	Avoid use of SendNumArgsReg which is the flag determining whether
	context switch is allowed on stack-overflow."
	<inline: false>
	needsFrame ifFalse: [^self].
	backEnd hasLinkRegister ifTrue: [self PushR: LinkReg].
	self PushR: FPReg.
	self MoveR: SPReg R: FPReg.
	"Think of ClassReg as ClosureReg"
	self MoveR: ReceiverResultReg R: ClassReg.
	"The block method field must have its MFMethodFlagIsBlockFlag bit set.
	 We arrange this using a labelOffset.  A hack, but it works."
	methodLabel addDependent: (self annotateAbsolutePCRef:
			(self PushCw: methodLabel asInteger));
			setLabelOffset: MFMethodFlagIsBlockFlag.. "method"
	self genMoveNilR: SendNumArgsReg.
	self PushR: SendNumArgsReg. "context"
	"Closure is on stack and initially in ReceiverResultReg.
	 It is safe to use Arg0Reg because reg args are pushed by the value primitives if there are any.".

	self flag: #TODO. "we could follow the receiver only if the block has inst var ref. Currently we use scanMethod for fullBlock 
	and that scanner does not provide this information. We could extend it based on the scanBlock: method"
	"Use ReceiverResultReg for the closure to agree with store check trampoline"
	objectRepresentation
		genLoadSlot: FullClosureReceiverIndex
			sourceReg: ClassReg
				destReg: Arg0Reg.
	objectRepresentation
		genEnsureOopInRegNotForwarded: Arg0Reg scratchReg: TempReg updatingSlot: FullClosureReceiverIndex in: ReceiverResultReg.
	self MoveR: Arg0Reg R: ReceiverResultReg.

	self PushR: ReceiverResultReg. "closure receiver"
	"Push copied values"
	0 to: numCopied - 1 do:
		[:i|
		objectRepresentation
			genLoadSlot: i + FullClosureFirstCopiedValueIndex
			sourceReg: ClassReg
			destReg: TempReg.
		self PushR: TempReg].
	"Push slots for temps"
	methodOrBlockNumArgs + numCopied + 1 to: (coInterpreter temporaryCountOfMethodHeader: methodHeader) do:
		[:i|
		self PushR: SendNumArgsReg].
	
	self MoveAw: coInterpreter stackLimitAddress R: TempReg.
	self CmpR: TempReg R: SPReg. "N.B. FLAGS := SPReg - TempReg"
	self JumpBelow: stackOverflowCall.
	stackCheckLabel := (self annotateBytecode: self Label)