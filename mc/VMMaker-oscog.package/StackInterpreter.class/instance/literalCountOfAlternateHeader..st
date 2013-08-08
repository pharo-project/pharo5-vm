compiled methods
literalCountOfAlternateHeader: headerPointer
	<inline: true>
	^(headerPointer >> 1) bitAnd: 16rFFFF