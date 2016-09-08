sista support
branchIf: reg notInstanceOfBehaviors: arrayObj target: targetFixUp
	"Generate a branch if reg is an instance of any of the classes in arrayObj,
	 otherwise fall-through. reg should not be edited."
	
	| allImmediate noneImmediate immediateMask numNonImmediates classObj |
	<var: #targetFixUp type: #'AbstractInstruction *'>
	
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

	noneImmediate ifTrue: [ ^ self noneImmediateBranchIf: reg notInstanceOfBehaviors: arrayObj target: targetFixUp ].

	allImmediate ifTrue: [ ^ self allImmediate: immediateMask branchIf: reg notInstanceOfBehaviors: arrayObj target: targetFixUp ].

	^ self mixed: numNonImmediates branchIf: reg notInstanceOfBehaviors: arrayObj target: targetFixUp