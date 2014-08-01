sista support
branchIfInstanceOfBehavior: classObj branches: branches
	<var: #branches type: #'AbstractInstruction *'>
	| jmpImmediate compactClassIndex |
	<var: #jmpImmediate type: #'AbstractInstruction *'>
	cogit MoveR: ReceiverResultReg R: TempReg.
	jmpImmediate := self genJumpSmallIntegerInScratchReg: TempReg.
	classObj = (objectMemory splObj: ClassSmallInteger) ifTrue:
		[branches at: 0 put: jmpImmediate.
		 ^0].
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
	^0