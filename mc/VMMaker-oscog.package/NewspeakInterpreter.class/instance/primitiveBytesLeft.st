memory space primitives
primitiveBytesLeft
	"Reports bytes available at this moment. For more meaningful 
	results, calls to this primitive should be preceeded by a full 
	or incremental garbage collection."
	| aBool |
	self methodArgumentCount = 0
		ifTrue: ["old behavior - just return the size of the free block"
			^self pop: 1 thenPushInteger: (self sizeOfFree: freeBlock)].
	self methodArgumentCount = 1
		ifTrue: ["new behaviour -including or excluding swap space depending on aBool"
			aBool := self booleanValueOf: self stackTop.
			self successful ifFalse: [^ nil].
			^self pop: 2 thenPushInteger: (self bytesLeft: aBool)].
	^ self primitiveFail