bytecode generator support
genEqualsEqualsNoBranchArgIsConstant: argIsConstant rcvrIsConstant: rcvrIsConstant argReg: argReg rcvrReg: rcvrReg
	"Generates the machine code for #== in the case where the instruction is not followed by a branch"
	| label jumpEqual jumpNotEqual |
	<var: #label type: #'AbstractInstruction *'>
	<var: #jumpEqual type: #'AbstractInstruction *'>
	<var: #jumpNotEqual type: #'AbstractInstruction *'>
	label := self Label.
	self genEqualsEqualsComparisonArgIsConstant: argIsConstant rcvrIsConstant: rcvrIsConstant argReg: argReg rcvrReg: rcvrReg.
	self ssPop: 2.
	jumpEqual := self JumpZero: 0.
	 argIsConstant ifFalse: [ objectRepresentation genEnsureOopInRegNotForwarded: argReg scratchReg: TempReg jumpBackTo: label ].
	 rcvrIsConstant ifFalse: [ objectRepresentation genEnsureOopInRegNotForwarded: rcvrReg scratchReg: TempReg jumpBackTo: label ].
	 self genMoveFalseR: rcvrReg.
	 jumpNotEqual := self Jump: 0.
	 jumpEqual jmpTarget: (self genMoveTrueR: rcvrReg).
	 jumpNotEqual jmpTarget: self Label.
	 self ssPushRegister: rcvrReg.
	 ^0