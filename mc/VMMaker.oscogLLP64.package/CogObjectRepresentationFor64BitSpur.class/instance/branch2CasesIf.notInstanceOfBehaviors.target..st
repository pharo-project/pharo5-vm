sista support
branch2CasesIf: reg notInstanceOfBehaviors: arrayObj target: targetFixUp
	"Only 2 immediate type allowed out of the three. Look for the third and jump to target fixup if it's the third.
	TempReg currently holds the rcvr tag and the receiver is immediate."
	
	| incorrectTag classObj tag1 tag2 |
	< inline: true>		
	
	"look for the 2 allowed tags"
	0 to: (objectMemory numSlotsOf: arrayObj) - 1 do:
		[:i|
		 classObj := objectMemory fetchPointer: i ofObject: arrayObj.
		 (objectMemory isImmediateClass: classObj)
			ifTrue: [ tag1
				ifNil: [tag1 := objectMemory classTagForClass: classObj ]
				ifNotNil: [tag2 := objectMemory classTagForClass: classObj ] ] ].
	
	incorrectTag := self fetchImmediateTagOtherThanTag1: tag1 tag2: tag2.
	cogit CmpCq: incorrectTag R: TempReg.
	cogit JumpZero: targetFixUp.
	