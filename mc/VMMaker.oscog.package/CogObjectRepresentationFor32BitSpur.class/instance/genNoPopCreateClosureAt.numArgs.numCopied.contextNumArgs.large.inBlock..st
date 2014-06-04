bytecode generator support
genNoPopCreateClosureAt: bcpc numArgs: numArgs numCopied: numCopied contextNumArgs: ctxtNumArgs large: isLargeCtxt inBlock: isInBlock
	"Create a closure with the given startpc, numArgs and numCopied
	 within a context with ctxtNumArgs, large if isLargeCtxt that is in a
	 block if isInBlock.  Do /not/ initialize the copied values."
	| slotSize header skip |
	<var: #skip type: #'AbstractInstruction *'>

	"First get thisContext into ReceiverResultRega and thence in ClassReg."
	self genGetActiveContextNumArgs: ctxtNumArgs large: isLargeCtxt inBlock: isInBlock.
	cogit MoveR: ReceiverResultReg R: ClassReg.

	slotSize := ClosureFirstCopiedValueIndex + numCopied.
	header := objectMemory
					headerForSlots: slotSize
					format: objectMemory indexablePointersFormat
					classIndex: ClassBlockClosureCompactIndex.
	cogit
		MoveAw: objectMemory freeStartAddress R: ReceiverResultReg;
		MoveCq: (self cCoerceSimple: header to: #usqInt) R: TempReg;
		MoveR: TempReg Mw: 0 r: ReceiverResultReg;
		MoveCq: header >> 32 R: TempReg;
		MoveR: TempReg Mw: 4 r: ReceiverResultReg;
		MoveR: ReceiverResultReg R: TempReg;
		AddCq: (objectMemory smallObjectBytesForSlots: slotSize) R: TempReg;
		MoveR: TempReg Aw: objectMemory freeStartAddress;
		CmpCq: objectMemory getScavengeThreshold R: TempReg.
	skip := cogit JumpBelow: 0.
	cogit CallRT: ceSheduleScavengeTrampoline.
	skip jmpTarget: cogit Label.

	cogit
		MoveR: ClassReg Mw: ClosureOuterContextIndex * BytesPerOop + BaseHeaderSize r: ReceiverResultReg;
		MoveCq: (objectMemory integerObjectOf: bcpc) R: TempReg;
		MoveR: TempReg Mw: ClosureStartPCIndex * BytesPerOop + BaseHeaderSize r: ReceiverResultReg;
		MoveCq: (objectMemory integerObjectOf: numArgs) R: TempReg;
		MoveR: TempReg Mw: ClosureNumArgsIndex * BytesPerOop + BaseHeaderSize r: ReceiverResultReg.
	^0