bytecode generators
genSpecialSelectorEqualsEquals
	"Override to count inlined branches if followed by a conditional branch.
	 We borrow the following conditional branch's counter and when about to
	 inline the comparison we decrement the counter (without writing it back)
	 and if it trips simply abort the inlining, falling back to the normal send which
	 will then continue to the conditional branch which will trip and enter the abort."
	| nextPC postBranchPC targetBytecodePC primDescriptor branchDescriptor nExts
	  counter countTripped unforwardArg unforwardRcvr |
	<var: #primDescriptor type: #'BytecodeDescriptor *'>
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>
	<var: #counter type: #'AbstractInstruction *'>
	<var: #countTripped type: #'AbstractInstruction *'>
	self ssFlushTo: simStackPtr - 2.
	primDescriptor := self generatorAt: byte0.

	nextPC := bytecodePC + primDescriptor numBytes.
	nExts := 0.
	[branchDescriptor := self generatorAt: (objectMemory fetchByte: nextPC ofObject: methodObj) + (byte0 bitAnd: 256).
	 branchDescriptor isExtension] whileTrue:
		[nExts := nExts + 1.
		 nextPC := nextPC + branchDescriptor numBytes].
	"Only interested in inlining if followed by a conditional branch."
	(branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse]) ifFalse:
		[^self genSpecialSelectorSend].

	targetBytecodePC := nextPC
							+ branchDescriptor numBytes
							+ (self spanFor: branchDescriptor at: nextPC exts: nExts in: methodObj).
	postBranchPC := nextPC + branchDescriptor numBytes.
	unforwardRcvr := (self ssValue: 1) type ~= SSConstant
						or: [objectRepresentation shouldAnnotateObjectReference: (self ssValue: 1) constant].
	unforwardArg := self ssTop type ~= SSConstant
						or: [objectRepresentation shouldAnnotateObjectReference: self ssTop constant].
	self marshallSendArguments: 1.

	self ssAllocateRequiredReg: SendNumArgsReg. "Use this as the count reg."
	counter := self addressOf: (counters at: counterIndex).
	self flag: 'will need to use MoveAw32:R: if 64 bits'.
	self assert: BytesPerWord = CounterBytes.
	counter addDependent: (self annotateAbsolutePCRef:
		(self MoveAw: counter asUnsignedInteger R: SendNumArgsReg)).
	self SubCq: 16r10000 R: SendNumArgsReg. "Count executed"
	"If counter trips simply abort the inlined comparison and send continuing to the following
	 branch *without* writing back.  A double decrement will not trip the second time."
	countTripped := self JumpCarry: 0.
	counter addDependent: (self annotateAbsolutePCRef:
		(self MoveR: SendNumArgsReg Aw: counter asUnsignedInteger)). "write back"
	unforwardRcvr ifTrue:
		[objectRepresentation genEnsureOopInRegNotForwarded: ReceiverResultReg scratchReg: TempReg].
	unforwardArg ifTrue:
		[objectRepresentation genEnsureOopInRegNotForwarded: Arg0Reg scratchReg: TempReg].
	self CmpR: Arg0Reg R: ReceiverResultReg.
	"Cmp is weird/backwards so invert the comparison.  Further since there is a following conditional
	 jump bytecode define non-merge fixups and leave the cond bytecode to set the mergeness."
	self gen: (branchDescriptor isBranchTrue ifTrue: [JumpZero] ifFalse: [JumpNonZero])
		operand: (self ensureNonMergeFixupAt: targetBytecodePC - initialPC) asUnsignedInteger.
	self SubCq: 1 R: SendNumArgsReg. "Count untaken"
	counter addDependent: (self annotateAbsolutePCRef:
		(self MoveR: SendNumArgsReg Aw: counter asUnsignedInteger)). "write back"
	self Jump: (self ensureNonMergeFixupAt: postBranchPC - initialPC).
	countTripped jmpTarget: self Label.
	^self genMarshalledSend: (coInterpreter specialSelector: byte0 - self firstSpecialSelectorBytecodeOffset)
		numArgs: 1