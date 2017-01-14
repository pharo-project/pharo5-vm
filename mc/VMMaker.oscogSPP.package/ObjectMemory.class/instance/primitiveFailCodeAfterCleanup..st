image segment in/out
primitiveFailCodeAfterCleanup: outPointerArray
	"If the storeSegment primitive fails, it must clean up first."

	| i lastAddr |   "Store nils throughout the outPointer array."
	lastAddr := outPointerArray + (self lastPointerOf: outPointerArray).
	i := outPointerArray + self baseHeaderSize.
	[i <= lastAddr] whileTrue:
		[self longAt: i put: nilObj.
		i := i + self wordSize].

	DoAssertionChecks ifTrue: [self verifyCleanHeaders].
	^PrimErrGenericFailure