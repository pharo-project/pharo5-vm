compiled methods
initialPCForHeader: methodHeader method: theMethod
	<api>
	^theMethod
	+ ((LiteralStart + (self literalCountOfHeader: methodHeader)) * BytesPerOop)
	+ objectMemory baseHeaderSize