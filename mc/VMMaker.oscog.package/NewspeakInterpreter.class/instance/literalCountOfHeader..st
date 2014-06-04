compiled methods
literalCountOfHeader: headerPointer
	^ (headerPointer >> 10) bitAnd: 16rFF