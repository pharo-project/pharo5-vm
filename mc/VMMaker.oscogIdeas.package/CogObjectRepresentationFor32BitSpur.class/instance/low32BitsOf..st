private
low32BitsOf: a64BitHeader
	<inline: true>
	^self cCode: [self cCoerceSimple: a64BitHeader to: #usqInt] inSmalltalk: [a64BitHeader bitAnd: 16rffffffff]