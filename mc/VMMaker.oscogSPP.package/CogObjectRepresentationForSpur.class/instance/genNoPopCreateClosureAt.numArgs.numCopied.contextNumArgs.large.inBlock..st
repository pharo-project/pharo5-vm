bytecode generator support
genNoPopCreateClosureAt: bcpc numArgs: numArgs numCopied: numCopied contextNumArgs: ctxtNumArgs large: isLargeCtxt inBlock: isInBlock
	"Create a closure with the given startpc, numArgs and numCopied
	 within a context with ctxtNumArgs, large if isLargeCtxt that is in a
	 block if isInBlock.  Do /not/ initialize the copied values."
	| numSlots byteSize header skip |
	<var: #skip type: #'AbstractInstruction *'>

	"First get thisContext into ReceiverResultRega and thence in ClassReg."
	self genGetActiveContextNumArgs: ctxtNumArgs large: isLargeCtxt inBlock: isInBlock.
	cogit MoveR: ReceiverResultReg R: ClassReg.

	numSlots := ClosureFirstCopiedValueIndex + numCopied.
	byteSize := objectMemory smallObjectBytesForSlots: numSlots.
	header := objectMemory
					headerForSlots: numSlots
					format: objectMemory indexablePointersFormat
					classIndex: ClassBlockClosureCompactIndex.
	cogit MoveAw: objectMemory freeStartAddress R: ReceiverResultReg.
	self genStoreHeader: header intoNewInstance: ReceiverResultReg using: TempReg.
	cogit
		LoadEffectiveAddressMw: byteSize r: ReceiverResultReg R: TempReg;
		MoveR: TempReg Aw: objectMemory freeStartAddress;
		CmpCq: objectMemory getScavengeThreshold R: TempReg.
	skip := cogit JumpBelow: 0.
	cogit CallRT: ceScheduleScavengeTrampoline.
	skip jmpTarget: cogit Label.

	cogit
		MoveR: ClassReg Mw: ClosureOuterContextIndex * objectMemory bytesPerOop + objectMemory baseHeaderSize r: ReceiverResultReg;
		MoveCq: (objectMemory integerObjectOf: bcpc) R: TempReg;
		MoveR: TempReg Mw: ClosureStartPCIndex * objectMemory bytesPerOop + objectMemory baseHeaderSize r: ReceiverResultReg;
		MoveCq: (objectMemory integerObjectOf: numArgs) R: TempReg;
		MoveR: TempReg Mw: ClosureNumArgsIndex * objectMemory bytesPerOop + objectMemory baseHeaderSize r: ReceiverResultReg.
	^0