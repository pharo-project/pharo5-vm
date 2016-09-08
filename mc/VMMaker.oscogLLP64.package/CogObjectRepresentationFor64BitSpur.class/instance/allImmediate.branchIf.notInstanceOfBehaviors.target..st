sista support
allImmediate: immediateMask branchIf: reg notInstanceOfBehaviors: arrayObj target: targetFixUp
	| incorrectTag tag1 tag2 |
	<var: #targetFixUp type: #'AbstractInstruction *'>
	(self genJumpNotImmediate: reg) jmpTarget: targetFixUp. 
	immediateMask = objectMemory tagMask ifFalse: 
		[ "TempReg holds the rcvr tag"
		"In this case one immediate tag out of the three is not present in arrayObj. 
		We look for it, and generate a jump to the fixup if the rcvr tag matches"
		tag1 := objectMemory classTagForClass: (objectMemory fetchPointer: 0 ofObject: arrayObj).
		tag2 := objectMemory classTagForClass: (objectMemory fetchPointer: 1 ofObject: arrayObj).
		incorrectTag :=  self fetchImmediateTagOtherThanTag1: tag1 tag2: tag2.
		cogit CmpCq: incorrectTag R: TempReg.
		cogit JumpZero: targetFixUp].
	^0