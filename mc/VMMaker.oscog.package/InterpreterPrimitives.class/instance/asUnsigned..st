primitive support
asUnsigned: anInteger
	<inline: true>
	^self cCode: [anInteger asUnsignedInteger] inSmalltalk: [anInteger bitAnd: objectMemory maxCInteger]