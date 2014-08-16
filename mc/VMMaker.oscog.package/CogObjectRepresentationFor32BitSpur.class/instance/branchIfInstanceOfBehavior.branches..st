in-line cacheing
branchIfInstanceOfBehavior: classObj branches: branches
	"Generate a branch if ReceiverResultReg is an instance of classObj, otherwise fall-
	 through. Store the branch in branches and answer the number of branches generated."
	<var: #branches type: #'AbstractInstruction **'>
	| jmpImmediate classIndex |
	<var: #jmpImmediate type: #'AbstractInstruction *'>
	classIndex := objectMemory classTagForClass: classObj.
	cogit MoveR: ReceiverResultReg R: TempReg.
	(objectMemory isImmediateClass: classObj)
		ifTrue:
			[classIndex = objectMemory smallIntegerTag ifTrue:
				[jmpImmediate := self genJumpSmallIntegerInScratchReg: TempReg].
			 classIndex = objectMemory characterTag ifTrue:
				[jmpImmediate := self genJumpCharacterInScratchReg: TempReg].
			 branches at: 0 put: jmpImmediate]
		ifFalse:
			[jmpImmediate := self genJumpImmediateInScratchReg: TempReg.
			 self genGetClassIndexOfNonImm: ReceiverResultReg into: TempReg.
			 self genCmpClassIndex: classIndex R: TempReg.
			 branches at: 0 put: (cogit JumpZero: 0).
			 jmpImmediate jmpTarget: cogit Label].
	^1