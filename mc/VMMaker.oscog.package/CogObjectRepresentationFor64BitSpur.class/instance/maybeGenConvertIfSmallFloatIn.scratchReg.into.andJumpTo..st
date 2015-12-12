primitive generators
maybeGenConvertIfSmallFloatIn: oopReg scratchReg: scratch into: dpReg andJumpTo: targetInst
	"Generate a test for a smallFloat in  oopReg, converting it to the float value in dpReg and jumping to targetInst.
	 c.f. Spur64BitMemoryManager>>smallFloatBitsOf:"
	<var: 'targetInst' type: #'AbstractInstruction *'>
	| jumpNotSF jumpSFZero |
	<var: 'jumpNotSF' type: #'AbstractInstruction *'>
	<var: 'jumpSFZero' type: #'AbstractInstruction *'>
	jumpNotSF := self genJumpNotSmallFloat: oopReg scratchReg: scratch.
	cogit
		MoveR: oopReg R: scratch;
		LogicalShiftRightCq: objectMemory numTagBits R: scratch;
		CmpCq: 1 R: scratch.
	jumpSFZero := cogit JumpAbove: 0.
	cogit AddCq: objectMemory smallFloatExponentOffset << (objectMemory smallFloatMantissaBits + 1) R: scratch.
	jumpSFZero jmpTarget: (cogit RotateRightCq: 1 R: scratch).
	cogit
		MoveR: scratch Rd: dpReg;
		Jump: targetInst.
	jumpNotSF jmpTarget: cogit Label.
	^0