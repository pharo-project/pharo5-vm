object access primitives
primitiveAllInstances
	"Answer an array of all instances of the receiver that exist
	 when the primitive is called, excluding any that may be
	 garbage collected as a side effect of allocating the result array."

	<export: true>
	| result |
	result := objectMemory allInstancesOf: self stackTop.
	(objectMemory isIntegerObject: result) ifTrue:
		[objectMemory growToAccomodateContainerWithNumSlots: (objectMemory integerValueOf: result).
		 result := objectMemory allInstancesOf: self stackTop.
		 (objectMemory isIntegerObject: result) ifTrue:
			[^self primitiveFailFor: PrimErrNoMemory]].
	self pop: argumentCount+1 thenPush: result