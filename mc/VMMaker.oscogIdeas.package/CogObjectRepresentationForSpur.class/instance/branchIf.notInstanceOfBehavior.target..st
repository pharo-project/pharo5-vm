sista support
branchIf: reg notInstanceOfBehavior: classObj target: targetFixUp
	"Generate a branch if reg is an instance of classObj, otherwise fall-
	 through. Cannot change the value of reg (may be used afterwards)."
	| classIndex |
	<inline: true>
	<var: #targetFixUp type: #'AbstractInstruction *'>
	classIndex := objectMemory classTagForClass: classObj.
	classIndex = (objectMemory fetchClassTagOf: objectMemory falseObject)
		ifTrue: [ self branchIf: reg isNotOop: objectMemory falseObject target: targetFixUp ].
	classIndex = (objectMemory fetchClassTagOf: objectMemory trueObject)
		ifTrue: [ self branchIf: reg isNotOop:  objectMemory trueObject target: targetFixUp ].
	classIndex = (objectMemory fetchClassTagOf: objectMemory nilObject)
		ifTrue: [ self branchIf: reg isNotOop:  objectMemory nilObject target: targetFixUp ].
	(objectMemory isImmediateClass: classObj)
		ifTrue:
			[self branchIf: reg hasNotImmediateTag: classIndex target: targetFixUp ]
		ifFalse:
			[(self genJumpImmediate: reg) jmpTarget: targetFixUp.
			 self genGetClassIndexOfNonImm: reg into: TempReg.
			 self genCmpClassIndex: classIndex R: TempReg.
			 cogit JumpNonZero: targetFixUp ].
	^0