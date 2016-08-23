primitive support
asUnsigned: anInteger
	<inline: true>
	^self cCode: [anInteger asUnsignedIntegerPtr] inSmalltalk: [anInteger bitAnd: objectMemory maxCInteger]