compiled methods
firstBytecodeOfAlternateHeader: methodHeader method: theMethod
	^theMethod + ((LiteralStart + (self literalCountOfAlternateHeader: methodHeader)) * BytesPerWord) + BaseHeaderSize