in-line cacheing
branchIfInstanceOfBehaviors: arrayObj branches: branches
	"Generate a branch if ReceiverResultReg is an instance of any of the classes in arrayObj,
	 otherwise fall-through. Store the branch in branches and answer the number of branches
	 generated."
	<var: #branches type: #'AbstractInstruction **'>
	| allImmediate noneImmediate immediateMask numNonImmediates classObj jmpNoMatch jmpImmediate branchIndex classIndex |
	<var: #jmpNoMatch type: #'AbstractInstruction *'>
	<var: #jmpImmediate type: #'AbstractInstruction *'>
	branchIndex := 0.
	"let me tell you all about it, let me falsify"
	allImmediate := true. noneImmediate := true. immediateMask := 0. numNonImmediates := 0.
	0 to: (objectMemory numSlotsOf: arrayObj) - 1 do:
		[:i|
		 classObj := objectMemory fetchPointer: i ofObject: arrayObj.
		 (objectMemory isImmediateClass: classObj)
			ifTrue:
				[noneImmediate := false.
				 immediateMask := immediateMask + (objectMemory classTagForClass: classObj)]
			ifFalse:
				[allImmediate := false.
				 numNonImmediates := numNonImmediates + 1]].

	noneImmediate ifTrue:
		[cogit MoveR: ReceiverResultReg R: TempReg.
		 jmpImmediate := self genJumpImmediateInScratchReg: TempReg.
		 self genGetCompactClassIndexNonImmOf: ReceiverResultReg into: TempReg.
		 0 to: (objectMemory numSlotsOf: arrayObj) - 1 do:
			[:i|
			 classObj := objectMemory fetchPointer: i ofObject: arrayObj.
			 self genCmpClassIndex: (objectMemory classTagForClass: classObj) R: TempReg.
			 branches at: branchIndex put: (cogit JumpZero: 0).
			 branchIndex := branchIndex + 1].
		 jmpImmediate jmpTarget: cogit Label].

	allImmediate ifTrue:
		[immediateMask = objectMemory tagMask
			ifTrue:
				[jmpImmediate := self genJumpImmediateInScratchReg: TempReg.
				 branches at: branchIndex put: jmpImmediate.
				 branchIndex := branchIndex + 1]
			ifFalse:
				[0 to: (objectMemory numSlotsOf: arrayObj) - 1 do:
					[:i|
					 cogit MoveR: ReceiverResultReg R: TempReg.
					 classObj := objectMemory fetchPointer: i ofObject: arrayObj.
					 classIndex := objectMemory classTagForClass: classObj.
					 classIndex = objectMemory smallIntegerTag ifTrue:
						[jmpImmediate := self genJumpSmallIntegerInScratchReg: TempReg].
					 classIndex = objectMemory characterTag ifTrue:
						[jmpImmediate := self genJumpCharacterInScratchReg: TempReg].
					 branches at: branchIndex put: jmpImmediate.
					 branchIndex := branchIndex + 1]]].

	(allImmediate or: [noneImmediate]) ifFalse:
		[cogit MoveR: ReceiverResultReg R: TempReg.
		 jmpImmediate := self genJumpImmediateInScratchReg: TempReg.
		 self genGetCompactClassIndexNonImmOf: ReceiverResultReg into: TempReg.
		 0 to: (objectMemory numSlotsOf: arrayObj) - 1 do:
			[:i|
			 classObj := objectMemory fetchPointer: i ofObject: arrayObj.
			 (objectMemory isImmediateClass: classObj) ifFalse:
			 	[self genCmpClassIndex: (objectMemory classTagForClass: classObj) R: TempReg.
				 branches at: branchIndex put: (cogit JumpZero: 0).
				 branchIndex := branchIndex + 1]].
		 jmpNoMatch := cogit Jump: 0.
		 jmpImmediate jmpTarget: cogit Label.
		 0 to: (objectMemory numSlotsOf: arrayObj) - 1 do:
			[:i|
			 classObj := objectMemory fetchPointer: i ofObject: arrayObj.
			 (objectMemory isImmediateClass: classObj) ifTrue:
			 	["first time through TempReg already contains tag pattern, so no need to reload it."
				 branchIndex > numNonImmediates ifTrue:
					[cogit MoveR: ReceiverResultReg R: TempReg].
				 classIndex := objectMemory classTagForClass: classObj.
				 classIndex = objectMemory smallIntegerTag ifTrue:
					[jmpImmediate := self genJumpSmallIntegerInScratchReg: TempReg].
				 classIndex = objectMemory characterTag ifTrue:
					[jmpImmediate := self genJumpCharacterInScratchReg: TempReg].
				 branches at: branchIndex put: jmpImmediate.
				 branchIndex := branchIndex + 1]].
		 jmpNoMatch jmpTarget: cogit Label].

	self assert: branchIndex <= (objectMemory numSlotsOf: arrayObj).
	^branchIndex