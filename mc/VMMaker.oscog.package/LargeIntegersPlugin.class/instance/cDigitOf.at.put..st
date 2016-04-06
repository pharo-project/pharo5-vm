C core util
cDigitOf: cPointer at: zeroBasedDigitIndex put: aValue
	<inline: true>
	<returnTypeC: #'unsigned int'>
	<var: 'cPointer' type: #'unsigned int *'>
	<var: 'aValue' type: #'unsigned int'>
	^cPointer at: zeroBasedDigitIndex put: (self byteSwapped32IfBigEndian: aValue)