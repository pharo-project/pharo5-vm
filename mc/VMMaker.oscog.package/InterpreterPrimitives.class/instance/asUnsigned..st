primitive support
asUnsigned: anInteger
	<inline: true>
	^self cCode: [anInteger asUnsignedLong] inSmalltalk: [anInteger bitAnd: objectMemory maxSmallInteger]