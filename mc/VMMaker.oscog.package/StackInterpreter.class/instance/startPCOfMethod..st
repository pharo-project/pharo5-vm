compiled methods
startPCOfMethod: aCompiledMethod
	<api>
	"Zero-relative version of CompiledMethod>>startpc."
	^(objectMemory literalCountOf: aCompiledMethod) + LiteralStart * objectMemory bytesPerOop