primitive generators
maybeGenConvertIfSmallFloatIn: oopReg scratchReg: scratch into: dpReg andJumpTo: targetInst
	"Generate a test for a smallFloat in oopReg, converting it to the float value in dpReg
	 and jumping to targetInst. If oopReg does not contain a SmallFloat, fall through."
	<var: 'targetInst' type: #'AbstractInstruction *'>
	| jumpNotSF |
	<var: 'jumpNotSF' type: #'AbstractInstruction *'>
	jumpNotSF := self genJumpNotSmallFloat: oopReg.
	self genGetSmallFloatValueOf: oopReg scratch: scratch into: dpReg.
	cogit Jump: targetInst.
	jumpNotSF jmpTarget: cogit Label.
	^0