primitive support
primitiveResponse
	"Called under the assumption that primitiveFunctionPointer is not preloaded"
	primitiveFunctionPointer := self functionPointerFor: primitiveIndex inClass: nil.
	^self internalPrimitiveResponse