compiled methods
startPCOfMethodHeader: methodHeader
	"Answer the zero-relative index to the initial byte for a method.
	 Zero-relative version of CompiledMethod>>startpc."
	^(objectMemory literalCountOfMethodHeader: methodHeader) + LiteralStart * objectMemory bytesPerOop