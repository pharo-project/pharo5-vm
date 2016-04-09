deprecated - array and stream primitives
primitiveAtEnd
	"nb: This primitive was previously installed as primitive 67, but is no
	longer in use."
	| stream index limit |
	stream := self popStack.
	((objectMemory isPointers: stream)
			and: [(objectMemory lengthOf: stream) >= (StreamReadLimitIndex+1)])
		ifTrue: [index := self fetchInteger: StreamIndexIndex ofObject: stream.
			limit := self fetchInteger: StreamReadLimitIndex ofObject: stream]
		ifFalse: [self primitiveFail].
 	self successful
		ifTrue: [self pushBool: (index >= limit)]
		ifFalse: [self unPop: 1].