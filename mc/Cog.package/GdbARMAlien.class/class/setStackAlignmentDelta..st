accessing
setStackAlignmentDelta: 	stackAlignmentDelta
	"copy of BochsIA32Alien>>#setStackAlignmentDelta:, because I don't know yet what it's effect is."
	self assert: stackAlignmentDelta isPowerOfTwo.
	PostBuildStackDelta :=  stackAlignmentDelta > 8
								ifTrue: [stackAlignmentDelta - 8]
								ifFalse: [0]