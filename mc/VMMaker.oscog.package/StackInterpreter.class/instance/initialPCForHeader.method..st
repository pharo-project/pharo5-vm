compiled methods
initialPCForHeader: methodHeader method: theMethod
	"Answer the initial PC for a method; used only in methods that build a frame."
	<inline: true>
	^theMethod
	+ ((LiteralStart + (objectMemory literalCountOfMethodHeader: methodHeader)) * objectMemory bytesPerOop)
	+ objectMemory baseHeaderSize