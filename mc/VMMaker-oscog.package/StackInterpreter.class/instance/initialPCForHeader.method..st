compiled methods
initialPCForHeader: methodHeader method: theMethod
	<api>
	^theMethod + ((LiteralStart + (self literalCountOfHeader: methodHeader)) * BytesPerWord) + BaseHeaderSize