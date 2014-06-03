image segment in/out
primitiveFailCodeAfterCleanup: outPointerArray
	"If the storeSegment primitive fails, it must clean up first."

	| i lastAddr |   "Store nils throughout the outPointer array."
	lastAddr := outPointerArray + (self lastPointerOf: outPointerArray).
	i := outPointerArray + BaseHeaderSize.
	[i <= lastAddr] whileTrue:
		[self longAt: i put: nilObj.
		i := i + BytesPerWord].

	DoAssertionChecks ifTrue: [self verifyCleanHeaders].
	^PrimErrGenericFailure