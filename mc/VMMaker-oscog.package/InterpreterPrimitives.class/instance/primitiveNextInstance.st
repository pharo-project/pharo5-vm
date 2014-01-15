object access primitives
primitiveNextInstance
	| object classPointer subsequentObject |
	object := self stackTop.
	(objectMemory isIntegerObject: object) ifFalse:
		[classPointer := objectMemory fetchClassOfNonInt: object.
		subsequentObject := objectMemory objectAfter: object.
		[self oop: subsequentObject isLessThan: objectMemory freeStart] whileTrue:
			[((objectMemory isFreeObject: subsequentObject) not
			  and: [(objectMemory fetchClassOfNonInt: subsequentObject) = classPointer]) ifTrue:
				[^self pop: argumentCount+1 thenPush: subsequentObject].
			 subsequentObject := objectMemory objectAfter: subsequentObject]].
	self primitiveFail