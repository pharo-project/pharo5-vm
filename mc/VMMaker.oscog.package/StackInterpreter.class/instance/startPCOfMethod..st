compiled methods
startPCOfMethod: aCompiledMethod
	<api>
	"Zero-relative version of CompiledMethod>>startpc."
	^(self literalCountOf: aCompiledMethod) + LiteralStart * objectMemory bytesPerOop