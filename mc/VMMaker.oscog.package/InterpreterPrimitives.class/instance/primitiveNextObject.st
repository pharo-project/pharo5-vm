object access primitives
primitiveNextObject
	"Return the object following the receiver in the heap. Return the SmallInteger zero when there are no more objects."

	(objectMemory accessibleObjectAfter: self stackTop)
		ifNil: [self pop: argumentCount+1 thenPushInteger: 0]
		ifNotNil: [:instance|
			self assert: (objectMemory isInMemory: instance).
			self pop: argumentCount+1 thenPush: instance]