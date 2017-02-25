compile abstract instructions
genGetNumBytesOf: srcReg into: destReg
	"Get the size in byte-sized slots of the object in srcReg into destReg.
	 srcReg may equal destReg.
	 destReg <- numSlots << self shiftForWord - (fmt bitAnd: 7).
	 Assumes the object in srcReg has a byte format, i.e. 16 to 23 or 24 to 31 "
	<var: #jmp type: #'AbstractInstruction *'>
	| jmp |
	self genGetRawSlotSizeOfNonImm: srcReg into: destReg.
	cogit CmpCq: objectMemory numSlotsMask R: destReg.
	jmp := cogit JumpLess: 0.
	self genGetOverflowSlotsOf: srcReg into: destReg.
	jmp jmpTarget: (cogit LogicalShiftLeftCq: objectMemory shiftForWord R: destReg). 
	self genGetBits: 7 ofFormatByteOf: srcReg into: TempReg.
	"Now: fmt bitAnd: 3 in TempReg"
	cogit SubR: TempReg R: destReg.
	^0