sista support
noneImmediateBranchIf: reg instanceOfBehaviors: arrayObj target: targetFixUp
	"All classes in arrayObj are not immediate"
	| classObj jmp |
	<var: #targetFixUp type: #'AbstractInstruction *'>
	<var: #jmp type: #'AbstractInstruction *'>
	jmp := self genJumpImmediate: reg.
	self genGetClassIndexOfNonImm: reg into: TempReg.
	0 to: (objectMemory numSlotsOf: arrayObj) - 1 do:
		[:i|
		 classObj := objectMemory fetchPointer: i ofObject: arrayObj.
		 self genCmpClassIndex: (objectMemory classTagForClass: classObj) R: TempReg.
		cogit JumpZero: targetFixUp ].
	jmp jmpTarget: self Label.
	^0