sista support
branchIf: reg instanceOfBehavior: classObj target: targetFixUp
	"Generate a branch if reg is an instance of classObj, otherwise fall-
	 through. Cannot change the value of reg (may be used afterwards)."
	| classIndex jmp |
	<inline: true>
	<var: #targetFixUp type: #'AbstractInstruction *'>
	<var: #jmp type: #'AbstractInstruction *'>
	classIndex := objectMemory classTagForClass: classObj.
	classIndex = (objectMemory fetchClassTagOf: objectMemory falseObject)
		ifTrue: [ self branchIf: reg isOop: objectMemory falseObject target: targetFixUp ].
	classIndex = (objectMemory fetchClassTagOf: objectMemory trueObject)
		ifTrue: [ self branchIf: reg isOop: objectMemory trueObject target: targetFixUp ].
	classIndex = (objectMemory fetchClassTagOf: objectMemory nilObject)
		ifTrue: [ self branchIf: reg isOop: objectMemory nilObject target: targetFixUp ].
	(objectMemory isImmediateClass: classObj)
		ifTrue:
			[self branchIf: reg hasImmediateTag: classIndex target: targetFixUp ]
		ifFalse:
			[jmp := (self genJumpImmediate: reg) .
			 self genGetClassIndexOfNonImm: reg into: TempReg.
			 self genCmpClassIndex: classIndex R: TempReg.
			 cogit JumpZero: targetFixUp.
			jmp jmpTarget: cogit Label ].
	^0