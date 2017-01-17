compiled methods
initialIPForHeader: methodHeader method: theMethod
	"Answer a pointer to the initial byte for a method; used only in methods that build a frame."
	<inline: true>
	^theMethod
	+ ((LiteralStart + (objectMemory literalCountOfMethodHeader: methodHeader)) * objectMemory bytesPerOop)
	+ objectMemory baseHeaderSize