bytecode generator support
genNewArrayOfSize: size initialized: initialized
	"Generate a call to code that allocates a new Array of size.
	 The Array should be initialized with nils iff initialized is true.
	 The size arg is passed in SendNumArgsReg, the result
	 must come back in ReceiverResultReg."
	| header skip |
	<var: #skip type: #'AbstractInstruction *'>
	self assert: size < objectMemory numSlotsMask.
	header := objectMemory
					headerForSlots: size
					format: objectMemory arrayFormat
					classIndex: ClassArrayCompactIndex.
	self flag: #endianness.
	cogit
		MoveAw: objectMemory freeStartAddress R: ReceiverResultReg;
		MoveCq: (self cCoerceSimple: header to: #usqInt) R: TempReg;
		MoveR: TempReg Mw: 0 r: ReceiverResultReg;
		MoveCq: header >> 32 R: TempReg;
		MoveR: TempReg Mw: 4 r: ReceiverResultReg.
	(initialized and: [size > 0]) ifTrue:
		[cogit MoveCw: objectMemory nilObject R: TempReg.
		 1 to: size do:
			[:i| cogit MoveR: TempReg Mw: i * 4 + 4 r: ReceiverResultReg]].
	cogit
		MoveR: ReceiverResultReg R: TempReg;
		AddCq: (objectMemory smallObjectBytesForSlots: size) R: TempReg;
		MoveR: TempReg Aw: objectMemory freeStartAddress;
		CmpCq: objectMemory getScavengeThreshold R: TempReg.
	skip := cogit JumpBelow: 0.
	cogit CallRT: ceSheduleScavengeTrampoline.
	skip jmpTarget: cogit Label.
	^0