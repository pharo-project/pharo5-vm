array and stream primitives
primitiveAtEnd
	| stream index limit |
	stream := self popStack.
	self success: ((self isPointers: stream)
					and: [(self lengthOf: stream) >= (StreamReadLimitIndex+1)]).
 	self successful ifTrue: [
		index := self fetchInteger: StreamIndexIndex ofObject: stream.
		limit := self fetchInteger: StreamReadLimitIndex ofObject: stream].
 	self successful
		ifTrue: [self pushBool: (index >= limit)]
		ifFalse: [self unPop: 1].