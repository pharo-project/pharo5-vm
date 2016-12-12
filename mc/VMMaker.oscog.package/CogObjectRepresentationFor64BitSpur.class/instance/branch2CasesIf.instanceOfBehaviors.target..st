sista support
branch2CasesIf: reg instanceOfBehaviors: arrayObj target: targetFixUp
	| classObj tag1 tag2 |
	< inline: true>		
	
	"look for the 2 tags requiring jmps"
	0 to: (objectMemory numSlotsOf: arrayObj) - 1 do:
		[:i|
		 classObj := objectMemory fetchPointer: i ofObject: arrayObj.
		 (objectMemory isImmediateClass: classObj)
			ifTrue: [ tag1
				ifNil: [tag1 := objectMemory classTagForClass: classObj ]
				ifNotNil: [tag2 := objectMemory classTagForClass: classObj ] ] ].
		
	(tag1 = objectMemory smallIntegerTag or: [tag2 = objectMemory smallIntegerTag]) ifTrue:
		[(self genJumpSmallIntegerInScratchReg: TempReg) jmpTarget: targetFixUp].
	(tag1 = objectMemory characterTag or: [tag2 = objectMemory characterTag]) ifTrue:
		[(self genJumpCharacterInScratchReg: TempReg) jmpTarget: targetFixUp].
	(tag1 = objectMemory smallFloatTag or: [tag2 = objectMemory smallFloatTag]) ifTrue:
		[(self genJumpSmallFloatInScratchReg: TempReg) jmpTarget: targetFixUp].
	^ 0