bytecode generator support
genEqualsEqualsNoBranchArgIsConstant: argIsConstant rcvrIsConstant: rcvrIsConstant argReg: argReg rcvrReg: rcvrRegOrNone
	"Generates the machine code for #== in the case where the instruction is not followed by a branch"
	| label jumpEqual jumpNotEqual resultReg |
	<var: #label type: #'AbstractInstruction *'>
	<var: #jumpEqual type: #'AbstractInstruction *'>
	<var: #jumpNotEqual type: #'AbstractInstruction *'>
	label := self Label.
	self genEqualsEqualsComparisonArgIsConstant: argIsConstant rcvrIsConstant: rcvrIsConstant argReg: argReg rcvrReg: rcvrRegOrNone.
	self ssPop: 2.
	resultReg := rcvrRegOrNone = NoReg ifTrue: [argReg] ifFalse: [rcvrRegOrNone].
	jumpEqual := self JumpZero: 0.
	 argIsConstant ifFalse:
		[objectRepresentation genEnsureOopInRegNotForwarded: argReg scratchReg: TempReg jumpBackTo: label].
	 rcvrIsConstant ifFalse:
		[objectRepresentation genEnsureOopInRegNotForwarded: rcvrRegOrNone scratchReg: TempReg jumpBackTo: label].
	 self genMoveFalseR: resultReg.
	 jumpNotEqual := self Jump: 0.
	 jumpEqual jmpTarget: (self genMoveTrueR: resultReg).
	 jumpNotEqual jmpTarget: self Label.
	 self ssPushRegister: resultReg.
	 ^0