C core util
cDigitOf: cPointer at: zeroBasedDigitIndex put: aValue
	<inline: true>
	<returnTypeC: #'unsigned int'>
	<var: 'cPointer' type: #'unsigned int *'>
	<var: 'aValue' type: #'unsigned int'>
	^(self cCode: [cPointer] inSmalltalk: [interpreterProxy cCoerce: cPointer to: #'unsigned int *'])
		at: zeroBasedDigitIndex
		put: (self byteSwapped32IfBigEndian: aValue)