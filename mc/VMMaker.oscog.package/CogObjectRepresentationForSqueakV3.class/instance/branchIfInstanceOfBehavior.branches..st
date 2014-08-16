sista support
branchIfInstanceOfBehavior: classObj branches: branches
	"Generate a branch if ReceiverResultReg is an instance of classObj, otherwise fall-
	 through. Store the branch in branches and answer the number of branches generated."
	<var: #branches type: #'AbstractInstruction **'>
	| jmpImmediate compactClassIndex |
	<var: #jmpImmediate type: #'AbstractInstruction *'>
	cogit MoveR: ReceiverResultReg R: TempReg.
	jmpImmediate := self genJumpSmallIntegerInScratchReg: TempReg.
	classObj = (objectMemory splObj: ClassSmallInteger) ifTrue:
		[branches at: 0 put: jmpImmediate.
		 ^1].
	(compactClassIndex := objectMemory compactClassIndexOfClass: classObj) ~= 0
		ifTrue:
			[self genGetCompactClassIndexNonImmOf: ReceiverResultReg into: TempReg.
			 cogit CmpCq: compactClassIndex R: TempReg]
		ifFalse:
			[self genGetClassObjectOfNonCompact: ReceiverResultReg into: TempReg.
			 cogit
				annotate: (cogit CmpCw: classObj R: TempReg)
				objRef: classObj].
	branches at: 0 put: (cogit JumpZero: 0).
	^1