array and stream primitives
primitiveSize
	| rcvr sz |
	rcvr := self stackTop.
	(self isIntegerObject: rcvr) ifTrue: [^ self primitiveFail].  "Integers are not indexable"
	(self formatOf: rcvr) < 2 ifTrue: [^ self primitiveFail].  "This is not an indexable object"
	sz := self stSizeOf: rcvr.
	self successful ifTrue:
		[self pop: argumentCount + 1 thenPush: (self positive32BitIntegerFor: sz)]
