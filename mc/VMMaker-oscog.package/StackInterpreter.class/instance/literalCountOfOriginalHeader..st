compiled methods
literalCountOfOriginalHeader: headerPointer
	<inline: true>
	^(headerPointer >> 10) bitAnd: 16rFF