primitive generators
genAllocFloatValue: dpreg into: resultReg scratchReg: scratch1 scratchReg: scratch2
	"Override to answer a SmallFloat64 if possible."
	<returnTypeC: #'AbstractInstruction *'>
	| jumpFail jumpNotSF jumpMerge |
	<var: #jumpFail type: #'AbstractInstruction *'>
	<var: #jumpNotSF type: #'AbstractInstruction *'>
	<var: #jumpMerge type: #'AbstractInstruction *'>
	cogit MoveRd: dpreg R: scratch2.
	jumpNotSF := self genJumpNotSmallFloatValueBits: scratch2 scratch: scratch1.
	self genConvertBitsToSmallFloatIn: scratch2 scratch: scratch1.
	jumpMerge := cogit Jump: 0.
	jumpNotSF jmpTarget: cogit Label.
	jumpFail := super genAllocFloatValue: dpreg into: resultReg scratchReg: scratch1 scratchReg: scratch2.
	jumpMerge jmpTarget: cogit Label.
	^jumpFail