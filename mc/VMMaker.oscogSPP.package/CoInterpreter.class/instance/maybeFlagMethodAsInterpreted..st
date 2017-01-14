compiled methods
maybeFlagMethodAsInterpreted: aMethod
	"The flag bit can be used to flag methods that are interpreted, if it has been requested
	 from the image header flags."
	flagInterpretedMethods ifTrue:
		[| rawHeader realHeader |
		 rawHeader := self rawHeaderOf: aMethod.
		 realHeader := (self isCogMethodReference: rawHeader)
						ifTrue: [(self cCoerceSimple: rawHeader to: #'CogMethod *') methodHeader]
						ifFalse: [rawHeader].
		 realHeader := realHeader bitOr: (objectMemory integerObjectOf: 1 << MethodHeaderFlagBitPosition).
		 (self isCogMethodReference: rawHeader)
			ifTrue: [(self cCoerceSimple: rawHeader to: #'CogMethod *') methodHeader: realHeader]
			ifFalse: [objectMemory storePointerUnchecked: 0 ofObject: aMethod withValue: realHeader]]