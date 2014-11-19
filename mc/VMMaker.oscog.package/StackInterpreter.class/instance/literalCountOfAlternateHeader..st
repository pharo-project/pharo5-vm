compiled methods
literalCountOfAlternateHeader: headerPointer
	<inline: true>
	^(objectMemory integerValueOf: headerPointer) bitAnd: 16rFFFF