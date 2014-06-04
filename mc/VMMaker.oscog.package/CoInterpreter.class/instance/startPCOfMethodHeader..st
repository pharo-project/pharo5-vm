compiled methods
startPCOfMethodHeader: aCompiledMethodHeader
	<api>
	"Zero-relative version of CompiledMethod>>startpc."
	^(self literalCountOfHeader: aCompiledMethodHeader) + LiteralStart * objectMemory bytesPerOop