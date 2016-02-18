compile abstract instructions
genGetNumSlotsOf: srcReg into: destReg
	"Get the size in word-sized slots of the object in srcReg into destReg.
	 srcReg may equal destReg."
	<var: #jmp type: #'AbstractInstruction *'>
	| jmp |
	self assert: srcReg ~= destReg.
	self genGetRawSlotSizeOfNonImm: srcReg into: destReg.
	cogit CmpCq: objectMemory numSlotsMask R: destReg.
	jmp := cogit JumpLess: 0.
	self genGetOverflowSlotsOf: srcReg into: destReg.
	jmp jmpTarget: cogit Label.
	^0