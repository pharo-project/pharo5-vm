frame access
externalInstVar: offset ofContext: aContext
	"Fetch an instance variable from a maybe married context.
	 If the context is still married compute the value of the
	 relevant inst var from the spouse frame's state."
	<inline: false>

	self assert: (objectMemory isContext: aContext).
	self assert: offset <= (ReceiverIndex + (self checkStackPointerForMaybeMarriedContext: aContext)).
	"method, closureOrNil & receiver need no special handling; only
	 sender, pc & stackp have to be computed for married contexts."
	(self isReadMediatedContextInstVarIndex: offset) ifTrue:
		[self externalWriteBackHeadFramePointers.
		 (self isStillMarriedContext: aContext) ifTrue:
			[^self fetchPointer: offset ofMarriedContext: aContext]].
	
	^objectMemory fetchPointer: offset ofObject: aContext