sista support
branchIf: reg notInstanceOfBehavior: classObj target: targetFixUp
	"Generate a branch if reg is an instance of classObj, otherwise fall-
	 through. Cannot change the value of reg (may be used afterwards)."
	| classIndex |
	<inline: true>
	<var: #targetFixUp type: #'AbstractInstruction *'>
	classIndex := objectMemory classTagForClass: classObj.
	(objectMemory isImmediateClass: classObj)
		ifTrue:
			[self branchIf: reg hasNotImmediateTag: classIndex target: targetFixUp ]
		ifFalse:
			[(self genJumpImmediate: reg) jmpTarget: targetFixUp.
			 self genGetClassIndexOfNonImm: reg into: TempReg.
			 self genCmpClassIndex: classIndex R: TempReg.
			 cogit JumpNonZero: targetFixUp ].
	^0