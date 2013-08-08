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
	self PushR: FPReg.
	self MoveR: SPReg R: FPReg.
	"The block method field must have its MFMethodFlagIsBlockFlag bit set.
	 We arrange this using a labelOffset.  A hack, but it works."
	blockStart fakeHeader
		addDependent: (self annotateAbsolutePCRef:
			(self PushCw: blockStart fakeHeader asInteger)); "method"
		setLabelOffset: MFMethodFlagIsBlockFlag.
	self annotate: (self PushCw: objectMemory nilObject) "context"
		objRef: objectMemory nilObject.
	"fetch home receiver from outer context. closure is on stack and initially in ReceiverResultReg"
	objectRepresentation
		genLoadSlot: ClosureOuterContextIndex
			sourceReg: ReceiverResultReg
				destReg: TempReg;
		genLoadSlot: ReceiverIndex
			sourceReg: TempReg
				destReg: ClassReg.
	self PushR: ClassReg. "home receiver"
	"Push copied values; bytecode initializes temporaries"
	0 to: blockStart numCopied - 1 do:
		[:i|
		objectRepresentation
			genLoadSlot: i + ClosureFirstCopiedValueIndex
			sourceReg: ReceiverResultReg
			destReg: TempReg.
		self PushR: TempReg].
	self MoveR: ClassReg R: ReceiverResultReg.
	self MoveAw: coInterpreter stackLimitAddress R: TempReg.
	self CmpR: TempReg R: SPReg. "N.B. FLAGS := SPReg - TempReg"
	self JumpBelow: stackOverflowCall.
	blockStart stackCheckLabel: (self annotateBytecode: self Label)