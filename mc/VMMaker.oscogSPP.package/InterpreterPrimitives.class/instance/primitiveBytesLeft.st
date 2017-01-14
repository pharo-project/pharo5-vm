memory space primitives
primitiveBytesLeft
	"Reports bytes available at this moment. For more meaningful 
	results, calls to this primitive should be precedeed by a full 
	or incremental garbage collection."
	| aBool |
	self methodArgumentCount = 0
		ifTrue: ["old behavior - just return the size of free memory"
			^self pop: 1 thenPushInteger: objectMemory freeSize].
	self methodArgumentCount = 1
		ifTrue: ["new behaviour -including or excluding swap space depending on aBool"
			aBool := self booleanValueOf: self stackTop.
			self successful ifTrue:
				[^self pop: 2 thenPushInteger: (objectMemory bytesLeft: aBool)]].
	^ self primitiveFail