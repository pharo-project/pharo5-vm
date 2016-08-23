I/O primitives
primitiveDeferDisplayUpdates
	"Set or clear the flag that controls whether modifications of 
	the Display object are propagated to the underlying 
	platform's screen."
	| flag |
	flag := self stackTop.
	flag = trueObj
		ifTrue: [deferDisplayUpdates := true]
		ifFalse: [flag = falseObj
				ifTrue: [deferDisplayUpdates := false]
				ifFalse: [self primitiveFail]].
	successFlag
		ifTrue: [self pop: 1]