control primitives
primitiveFindHandlerContext
	"Primitive. Search up the context stack for the next method context marked
	 for exception handling starting at the receiver. Return nil if none found"
	| handlerOrNilOrZero |
	self externalWriteBackHeadFramePointers.
	handlerOrNilOrZero := self
							findMethodWithPrimitive: 199
							FromContext: self stackTop
							UpToContext: objectMemory nilObject.
	handlerOrNilOrZero = 0 ifTrue:
		[handlerOrNilOrZero := objectMemory nilObject].
	self pop: 1 thenPush: handlerOrNilOrZero