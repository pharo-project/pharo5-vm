object access primitives
primitiveNextInstance
	| object subsequentObject |
	object := self stackTop.
	(objectMemory isImmediate: object) ifFalse:
		[subsequentObject := objectMemory instanceAfter: object.
		 subsequentObject ifNotNil:
			[^self pop: argumentCount+1 thenPush: subsequentObject]].
	self primitiveFail