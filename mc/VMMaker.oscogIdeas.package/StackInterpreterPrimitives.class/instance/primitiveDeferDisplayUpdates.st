I/O primitives
primitiveDeferDisplayUpdates
	"Set or clear the flag that controls whether modifications of 
	the Display object are propagated to the underlying 
	platform's screen."
	| flag |
	flag := self stackTop.
	flag = objectMemory trueObject
		ifTrue: [deferDisplayUpdates := true]
		ifFalse: [flag = objectMemory falseObject
				ifTrue: [deferDisplayUpdates := false]
				ifFalse: [self primitiveFail]].
	self successful
		ifTrue: [self pop: 1]