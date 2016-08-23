compiled methods
startPCOfMethodHeader: aCompiledMethodHeader
	<api>
	"Zero-relative version of CompiledMethod>>startpc."
	^(objectMemory literalCountOfMethodHeader: aCompiledMethodHeader) + LiteralStart * objectMemory bytesPerOop