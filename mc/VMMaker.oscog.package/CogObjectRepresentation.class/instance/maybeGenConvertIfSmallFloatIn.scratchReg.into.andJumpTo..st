primitive generators
maybeGenConvertIfSmallFloatIn: oopReg scratchReg: scratch into: dpReg andJumpTo: targetInst
	"If the receiver supports immediate floats then generate a test for a smallFloat in  oopReg,
	 converting it to the float value in dpReg and jumping to targetInst.  Otherwise do nothing."
	<var: 'targetInst' type: #'AbstractInstruction *'>
	^0