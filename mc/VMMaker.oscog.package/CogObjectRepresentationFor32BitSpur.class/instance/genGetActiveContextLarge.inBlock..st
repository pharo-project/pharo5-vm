initialization
genGetActiveContextLarge: isLarge inBlock: isInBlock
	"Create a trampoline to answer the active context that will
	 answer it if a frame is already married, and create it otherwise.
	 Assume numArgs is in SendNumArgsReg and ClassReg is free."
	| header slotSize jumpSingle loopHead jumpNeedScavenge continuation exit |
	<var: #jumpNeedScavenge type: #'AbstractInstruction *'>
	<var: #continuation type: #'AbstractInstruction *'>
	<var: #jumpSingle type: #'AbstractInstruction *'>
	<var: #loopHead type: #'AbstractInstruction *'>
	<var: #exit type: #'AbstractInstruction *'>
	cogit
		MoveMw: FoxMethod r: FPReg R: TempReg;
		MoveR: TempReg R: ClassReg;
		AndCq: MFMethodFlagHasContextFlag R: TempReg.
	jumpSingle := cogit JumpZero: 0.
	cogit
		MoveMw: FoxThisContext r: FPReg R: ReceiverResultReg;
		RetN: 0.
	jumpSingle jmpTarget: cogit Label.

	"OK, it doesn't exist; instantiate and initialize it"
	"set the hasContext flag; See CoInterpreter class>>initializeFrameIndices"
	cogit
		OrCq: MFMethodFlagHasContextFlag R: ClassReg;
		MoveR: ClassReg Mw: FoxMethod r: FPReg.
	"now get the home CogMethod into ClassReg and save for post-instantiation."
	isInBlock
		ifTrue:
			[cogit
				SubCq: 3 R: ClassReg; "-3 is -(hasContext+isBlock) flags"
				MoveM16: 0 r: ClassReg R: TempReg;
				SubR: TempReg R: ClassReg]
		ifFalse:
			[cogit SubCq: 1 R: ClassReg]. "-1 is hasContext flag"

	"instantiate the context..."
	slotSize := isLarge ifTrue: [LargeContextSlots] ifFalse: [SmallContextSlots].
	header := objectMemory
					headerForSlots: slotSize
					format: objectMemory indexablePointersFormat
					classIndex: ClassMethodContextCompactIndex.
	self flag: #endianness.
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
	jumpNeedScavenge := cogit JumpAboveOrEqual: 0.

	"Now initialize the fields of the context.  See CoInterpreter>>marryFrame:SP:copyTemps:"
	"sender gets frame pointer as a SmallInteger"
	continuation :=
	cogit MoveR: FPReg R: TempReg.
	self genSetSmallIntegerTagsIn: TempReg.
	cogit MoveR: TempReg Mw: BaseHeaderSize + (SenderIndex * BytesPerOop) r: ReceiverResultReg.

	"pc gets frame caller as a SmallInteger"
	cogit MoveMw: FoxSavedFP r: FPReg R: TempReg.
	self genSetSmallIntegerTagsIn: TempReg.
	cogit MoveR: TempReg Mw: BaseHeaderSize + (InstructionPointerIndex * BytesPerOop) r: ReceiverResultReg.

	"Set the method field, freeing up ClassReg again, and frame's context field,"
	cogit
		MoveMw: (cogit offset: CogMethod of: #methodObject) r: ClassReg R: TempReg;
		MoveR: TempReg Mw: BaseHeaderSize + (MethodIndex * BytesPerWord) r: ReceiverResultReg;
		MoveR: ReceiverResultReg Mw: FoxThisContext r: FPReg.

	"Now compute stack pointer; this is stackPointer (- 1 for return pc if a CISC) - framePointer - 4 (1 each for saved pc, method, context, receiver) + 1 (1-relative)"
	cogit
		MoveR: FPReg R: TempReg;
		SubR: SPReg R: TempReg;
		LogicalShiftRightCq: self log2BytesPerWord R: TempReg;
		SubCq: (cogit backEnd hasLinkRegister ifTrue: [3] ifFalse: [4]) R: TempReg;
		AddR: SendNumArgsReg R: TempReg.
	self genConvertIntegerToSmallIntegerInReg: TempReg.
	cogit MoveR: TempReg Mw: BaseHeaderSize + (StackPointerIndex * BytesPerOop) r: ReceiverResultReg.

	"Set closureOrNil to either the stacked receiver or nil"
	isInBlock
		ifTrue:
			[cogit
				MoveR: SendNumArgsReg R: TempReg;
				AddCq: 2 R: TempReg; "+2 for saved fp and saved pc"
				MoveXwr: TempReg R: FPReg R: TempReg]
		ifFalse:
			[cogit MoveCw: objectMemory nilObject R: TempReg].
	cogit MoveR: TempReg Mw: BaseHeaderSize + (ClosureIndex * BytesPerOop) r: ReceiverResultReg.

	"Set the receiver"
	cogit
		MoveMw: FoxMFReceiver r: FPReg R: TempReg;
		MoveR: TempReg Mw: BaseHeaderSize + (ReceiverIndex * BytesPerOop) r: ReceiverResultReg.

	"Now copy the arguments.  This is tricky because of the shortage of registers,.  ClassReg ranges
	 from 1 to numArgs (SendNumArgsReg), and from ReceiverIndex + 1 to ReceiverIndex + numArgs.
	 1 to: numArgs do:
		[:i|
		temp := longAt(FPReg + ((SendNumArgs - i + 2) * BytesPerWord)). +2 for saved pc and savedfp
		longAtput(FPReg + FoxMFReceiver + (i * BytesPerWord), temp)]"
	cogit MoveCq: 1 R: ClassReg.
	loopHead := cogit CmpR: SendNumArgsReg R: ClassReg.
	exit := cogit JumpGreater: 0.
	cogit
		MoveR: SendNumArgsReg R: TempReg;
		SubR: ClassReg R: TempReg;
		AddCq: 2 R: TempReg; "+2 for saved fp and saved pc"
		MoveXwr: TempReg R: FPReg R: TempReg;
		AddCq: ReceiverIndex + (BaseHeaderSize / BytesPerWord) R: ClassReg; "Now convert ClassReg from frame index to context index"
		MoveR: TempReg Xwr: ClassReg R: ReceiverResultReg;
		SubCq: ReceiverIndex + (BaseHeaderSize / BytesPerWord) - 1 R: ClassReg; "convert back adding 1 ;-)"
		Jump: loopHead.
	exit jmpTarget: cogit Label.

	"Finally copy the temps.
	 ClassReg := FPReg + FoxMFReceiver.
	 SendNumArgsReg := SendNumArgsReg+ReceiverIndex.
	 [ClassReg := ClassReg - 4.
	  backEnd hasLinkRegister
			ifTrue: [ClassReg > SPReg]
			ifFalse: [ClassReg >= SPReg]] whileTrue:
		[receiver[SendNumArgsReg] := *ClassReg.
		 SendNumArgsReg := SendNumArgsReg + 1]]"
	cogit
		MoveR: FPReg R: ClassReg;
		AddCq: FoxMFReceiver R: ClassReg;
		AddCq: ReceiverIndex + 1 + (BaseHeaderSize / BytesPerWord) R: SendNumArgsReg.
	loopHead :=
	cogit SubCq: BytesPerWord R: ClassReg.
	cogit CmpR: SPReg R: ClassReg.
	exit := cogit backEnd hasLinkRegister
				ifTrue: [cogit JumpBelowOrEqual: 0]
				ifFalse: [cogit JumpBelow: 0].
	cogit
		MoveMw: 0 r: ClassReg R: TempReg;
		MoveR: TempReg Xwr: SendNumArgsReg R: ReceiverResultReg;
		AddCq: 1 R: SendNumArgsReg;
		Jump: loopHead.
	exit jmpTarget: cogit Label.

	cogit RetN: 0.
	
	jumpNeedScavenge jmpTarget:
		(cogit CallRT: ceSheduleScavengeTrampoline).
	cogit Jump: continuation.
	^0