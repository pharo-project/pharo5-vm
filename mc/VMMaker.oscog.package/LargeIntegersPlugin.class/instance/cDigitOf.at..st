C core util
cDigitOf: cPointer at: zeroBasedDigitIndex
	<inline: true>
	<returnTypeC: #'unsigned int'>
	<var: 'cPointer' type: #'unsigned int *'>
	^self byteSwapped32IfBigEndian: (cPointer at: zeroBasedDigitIndex)