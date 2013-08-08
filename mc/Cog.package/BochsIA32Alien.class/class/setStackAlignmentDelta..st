accessing
setStackAlignmentDelta: 	stackAlignmentDelta
	self assert: stackAlignmentDelta isPowerOfTwo.
	PostBuildStackDelta :=  stackAlignmentDelta > 8
								ifTrue: [stackAlignmentDelta - 8]
								ifFalse: [0]