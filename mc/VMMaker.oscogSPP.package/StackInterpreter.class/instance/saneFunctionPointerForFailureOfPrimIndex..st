primitive support
saneFunctionPointerForFailureOfPrimIndex: primIndex
	^primitiveFunctionPointer = (self functionPointerFor: primIndex inClass: objectMemory nilObject)