frame access
externalInstVar: offset ofContext: aContext
	"Fetch an instance variable from a maybe married context.
	 If the context is still married compute the value of the
	 relevant inst var from the spouse frame's state."
	self assert: (objectMemory isContext: aContext).
	"method, closureOrNil & receiver need no special handling; only
	 sender, pc & stackp have to be computed for married contexts."
	((self isReadMediatedContextInstVarIndex: offset)
	 and: [self isMarriedOrWidowedContext: aContext]) ifFalse:
		[^objectMemory fetchPointer: offset ofObject: aContext].

	self externalWriteBackHeadFramePointers.
	^(self isStillMarriedContext: aContext)
		ifTrue: [self fetchPointer: offset ofMarriedContext: aContext]
		ifFalse: [objectMemory fetchPointer: offset ofObject: aContext]