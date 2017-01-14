compile abstract instructions
genGetSmallFloatValueOf: oopReg scratch: scratch into: dpReg
	"Convert the SmallFloat oop in ooppReg into the corresponding float value in dpReg.
	 c.f. Spur64BitMemoryManager>>smallFloatBitsOf:"
	| jumpSFZero |
	<var: 'jumpSFZero' type: #'AbstractInstruction *'>
	cogit
		MoveR: oopReg R: scratch;
		LogicalShiftRightCq: objectMemory numTagBits R: scratch;
		CmpCq: 1 R: scratch.
	jumpSFZero := cogit JumpLessOrEqual: 0.
	cogit AddCq: objectMemory smallFloatExponentOffset << (objectMemory smallFloatMantissaBits + 1) R: scratch.
	jumpSFZero jmpTarget: (cogit RotateRightCq: 1 R: scratch).
	cogit MoveR: scratch Rd: dpReg.
	^0