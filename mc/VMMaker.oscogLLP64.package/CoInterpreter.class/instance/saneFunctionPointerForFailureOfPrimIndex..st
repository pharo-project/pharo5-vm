primitive support
saneFunctionPointerForFailureOfPrimIndex: primIndex
	^instructionPointer >= objectMemory nilObject asUnsignedInteger
		ifTrue:
			[super saneFunctionPointerForFailureOfPrimIndex: primIndex]
		ifFalse:
			[self
				cCode:
					[primitiveFunctionPointer = (self functionPointerFor: primIndex
													inClass: objectMemory nilObject)]
				inSmalltalk:
					[(primitiveFunctionPointer isInteger
						ifTrue:
							[(cogit lookupAddress: primitiveFunctionPointer)
								endsWith: (self functionPointerFor: primIndex
												inClass: objectMemory nilObject)]
						ifFalse:
							[primitiveFunctionPointer = (self functionPointerFor: primIndex
															inClass: objectMemory nilObject)])]]