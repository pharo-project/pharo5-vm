compile abstract instructions
genGetNumSlotsOf: srcReg into: destReg
	"Get the size in word-sized slots of the object in srcReg into destReg.
	 srcReg may equal destReg."
	<var: #jmp type: #'AbstractInstruction *'>
	| jmp |
	self genGetRawSlotSizeOfNonImm: srcReg into: TempReg.
	cogit CmpCq: objectMemory numSlotsMask R: TempReg.
	jmp := cogit JumpLess: 0.
	cogit MoveMw: objectMemory wordSize negated r: srcReg R: TempReg.
	jmp jmpTarget: (cogit MoveR: TempReg R: destReg).
	^0