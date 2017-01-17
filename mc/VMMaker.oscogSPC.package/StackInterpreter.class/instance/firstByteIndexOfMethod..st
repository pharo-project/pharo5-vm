compiled methods
firstByteIndexOfMethod: methodObj
	"Answer the one-relative index of the first bytecode in methodObj.
	 Used for safer bounds-checking on methods."
	^(objectMemory literalCountOf: methodObj) + LiteralStart * objectMemory bytesPerOop + 1