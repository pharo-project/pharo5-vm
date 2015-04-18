sista support
noneImmediateBranchIf: reg notInstanceOfBehaviors: arrayObj target: targetFixUp
	"All classes in arrayObj are not immediate"
	| label numJumps jumps classObj |
	<inline: true>
	<var: #jumps type: #'AbstractInstruction **'>
	cogit MoveR: reg R: TempReg.
	jumps := self alloca: (objectMemory numSlotsOf: arrayObj) type: (self cCode: [#'AbstractInstruction *'] inSmalltalk: [cogit backEnd class])..
	(self genJumpImmediateInScratchReg: TempReg) jmpTarget: targetFixUp.
	self genGetClassIndexOfNonImm: reg into: TempReg.
	0 to: (numJumps := objectMemory numSlotsOf: arrayObj) - 1 do:
		[:i|
		 classObj := objectMemory fetchPointer: i ofObject: arrayObj.
		 self genCmpClassIndex: (objectMemory classTagForClass: classObj) R: TempReg.
		jumps at: i put: (cogit JumpZero: 0) ].
	cogit Jump: targetFixUp.
	label := self Label.
	0 to: numJumps do: [:i |
		(jumps at: i) jmpTarget: label ].
	^0