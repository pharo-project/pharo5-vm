compiled methods
initialPCForHeader: methodHeader method: theMethod
	<api>
	^theMethod
	+ ((LiteralStart + (objectMemory literalCountOfMethodHeader: methodHeader)) * BytesPerOop)
	+ objectMemory baseHeaderSize