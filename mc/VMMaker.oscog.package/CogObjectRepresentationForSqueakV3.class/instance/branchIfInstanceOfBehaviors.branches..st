sista support
branchIfInstanceOfBehaviors: arrayObj branches: branches
	"Generate a branch if ReceiverResultReg is an instance of any of the classes in arrayObj,
	 otherwise fall-through. Store the branch in branches and answer the number of branches
	 generated."
	<var: #branches type: #'AbstractInstruction **'>
	| anImmediate allCompact noneCompact classObj jmpImmediate jmpCompact branchIndex |
	<var: #jmpCompact type: #'AbstractInstruction *'>
	<var: #jmpImmediate type: #'AbstractInstruction *'>
	"let me tell you all about it, let me falsify"
	anImmediate := false. allCompact := true. noneCompact := true.
	0 to: (objectMemory numSlotsOf: arrayObj) - 1 do:
		[:i|
		 classObj := objectMemory fetchPointer: i ofObject: arrayObj.
		 classObj = (objectMemory splObj: ClassSmallInteger)
			ifTrue:
				[anImmediate := true]
			ifFalse:
				[(objectMemory compactClassIndexOfClass: classObj) = 0
					ifTrue: [allCompact := false]
					ifFalse: [noneCompact := false]]].
	cogit MoveR: ReceiverResultReg R: TempReg.
	branchIndex := 0.
	jmpImmediate := self genJumpSmallIntegerInScratchReg: TempReg.
	self genGetCompactClassIndexNonImmOf: ReceiverResultReg into: TempReg.
	noneCompact
		ifTrue:
			[cogit CmpCq: 0 R: TempReg.
			 jmpCompact := cogit JumpNonZero: 0]
		ifFalse:
			[0 to: (objectMemory numSlotsOf: arrayObj) - 1 do:
				[:i| | compactClassIndex |
				 classObj := objectMemory fetchPointer: i ofObject: arrayObj.
				 (classObj ~= (objectMemory splObj: ClassSmallInteger)
				  and: [(compactClassIndex := objectMemory compactClassIndexOfClass: classObj) ~= 0]) ifTrue:
					[cogit CmpCq: compactClassIndex R: TempReg.
					 branches at: branchIndex put: (cogit JumpZero: 0).
					 branchIndex := branchIndex + 1]]].
	allCompact ifFalse:
		[self genGetClassObjectOfNonCompact: ReceiverResultReg into: TempReg.
		 0 to: (objectMemory numSlotsOf: arrayObj) - 1 do:
			[:i|
			 classObj := objectMemory fetchPointer: i ofObject: arrayObj.
			 (classObj ~= (objectMemory splObj: ClassSmallInteger)
			  and: [(objectMemory compactClassIndexOfClass: classObj) = 0]) ifTrue:
				[cogit
					annotate: (cogit CmpCw: classObj R: TempReg)
					objRef: classObj.
				 branches at: branchIndex put: (cogit JumpZero: 0).
				 branchIndex := branchIndex + 1]]].
	"Either succeed or fail on the immediate test."
	anImmediate
		ifTrue: [branches at: branchIndex put: jmpImmediate.
				branchIndex := branchIndex + 1]
		ifFalse: [jmpImmediate jmpTarget: cogit Label].
	noneCompact ifTrue:
		[jmpCompact jmpTarget: cogit Label].
	self assert: branchIndex = (objectMemory numSlotsOf: arrayObj).
	^branchIndex