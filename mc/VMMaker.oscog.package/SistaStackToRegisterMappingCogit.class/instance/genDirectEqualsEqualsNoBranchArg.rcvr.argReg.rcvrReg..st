bytecode generators
genDirectEqualsEqualsNoBranchArg: unforwardArg rcvr: unforwardRcvr argReg: argReg rcvrReg: rcvrReg
	<inline: true>
	| label jumpEqual jumpNotEqual |
	label := self Label.
	self genEqualsEqualsComparisonArg: unforwardArg rcvr: unforwardRcvr argReg: argReg rcvrReg: rcvrReg.
	self ssPop: 2.
	jumpEqual := self JumpZero: 0.
	 unforwardArg ifTrue: [ objectRepresentation genEnsureOopInRegNotForwarded: argReg scratchReg: TempReg jumpBackTo: label ].
	 unforwardRcvr ifTrue: [ objectRepresentation genEnsureOopInRegNotForwarded: rcvrReg scratchReg: TempReg jumpBackTo: label ].
	 self genMoveFalseR: rcvrReg.
	 jumpNotEqual := self Jump: 0.
	 jumpEqual jmpTarget: (self genMoveTrueR: rcvrReg).
	 jumpNotEqual jmpTarget: self Label.
	 self ssPushRegister: rcvrReg.
	 ^0