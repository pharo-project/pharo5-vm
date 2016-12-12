sista support
allImmediate: immediateMask branchIf: reg instanceOfBehaviors: arrayObj target: targetFixUp
	| tag1 tag2 |
	<var: #targetFixUp type: #'AbstractInstruction *'>
	immediateMask = objectMemory tagMask ifTrue: [(self genJumpImmediate: reg) jmpTarget: targetFixUp. ^0].
	"TempReg holds the rcvr tag"
	"In this case one immediate tag out of the three is not present in arrayObj."
	tag1 := objectMemory classTagForClass: (objectMemory fetchPointer: 0 ofObject: arrayObj).
	tag2 := objectMemory classTagForClass: (objectMemory fetchPointer: 1 ofObject: arrayObj).
	(tag1 = objectMemory smallIntegerTag or: [tag2 = objectMemory smallIntegerTag]) ifTrue:
		[(self genJumpSmallIntegerInScratchReg: TempReg) jmpTarget: targetFixUp].
	(tag1 = objectMemory characterTag or: [tag2 = objectMemory characterTag]) ifTrue:
		[(self genJumpCharacterInScratchReg: TempReg) jmpTarget: targetFixUp].
	(tag1 = objectMemory smallFloatTag or: [tag2 = objectMemory smallFloatTag]) ifTrue:
		[(self genJumpSmallFloatInScratchReg: TempReg) jmpTarget: targetFixUp].
	^0