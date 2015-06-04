compile abstract instructions
compileBlockFrameBuild: blockStart
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
	<var: #blockStart type: #'BlockStart *'>
	<inline: false>
	self annotateBytecode: self Label.
	backEnd hasLinkRegister ifTrue:
		[self PushR: LinkReg].
	self PushR: FPReg.
	self MoveR: SPReg R: FPReg.
	"Think of ClassReg as ClosureReg"
	self MoveR: ReceiverResultReg R: ClassReg.
	"The block method field must have its MFMethodFlagIsBlockFlag bit set.
	 We arrange this using a labelOffset.  A hack, but it works."
	blockStart fakeHeader
		addDependent: (self annotateAbsolutePCRef:
			(self PushCw: blockStart fakeHeader asInteger)); "method"
		setLabelOffset: MFMethodFlagIsBlockFlag.
	self annotate: (self PushCw: objectMemory nilObject) "context"
		objRef: objectMemory nilObject.
	"Fetch home receiver from outer context. closure is on stack and initially in ReceiverResultReg.
	 It is safe to use Arg0Reg because reg args are pushed by the value primitives if there are any.".
	blockStart hasInstVarRef
		ifTrue: "Use ReceiverResultReg for Context to agree with store check trampoline"
			[objectRepresentation
				genLoadSlot: ClosureOuterContextIndex
					sourceReg: ClassReg
						destReg: ReceiverResultReg;
				genLoadSlot: ReceiverIndex
					sourceReg: ReceiverResultReg
						destReg: Arg0Reg.
			objectRepresentation
				genEnsureOopInRegNotForwarded: Arg0Reg scratchReg: TempReg updatingSlot: ReceiverIndex in: ReceiverResultReg.
			self MoveR: Arg0Reg R: ReceiverResultReg]
		ifFalse:
			[objectRepresentation
				genLoadSlot: ClosureOuterContextIndex
					sourceReg: ClassReg
						destReg: Arg0Reg;
				genLoadSlot: ReceiverIndex
					sourceReg: Arg0Reg
						destReg: ReceiverResultReg].
	self PushR: ReceiverResultReg. "home receiver"
	"Push copied values; bytecode initializes temporaries"
	0 to: blockStart numCopied - 1 do:
		[:i|
		objectRepresentation
			genLoadSlot: i + ClosureFirstCopiedValueIndex
			sourceReg: ClassReg
			destReg: TempReg.
		self PushR: TempReg].
	self MoveAw: coInterpreter stackLimitAddress R: TempReg.
	self CmpR: TempReg R: SPReg. "N.B. FLAGS := SPReg - TempReg"
	self JumpBelow: stackOverflowCall.
	blockStart stackCheckLabel: (self annotateBytecode: self Label)