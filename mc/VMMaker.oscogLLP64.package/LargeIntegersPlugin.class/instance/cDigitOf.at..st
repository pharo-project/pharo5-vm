C core util
cDigitOf: cPointer at: zeroBasedDigitIndex
	<inline: true>
	<returnTypeC: #'unsigned int'>
	<var: 'cPointer' type: #'unsigned int *'>
	^self byteSwapped32IfBigEndian: ((self cCode: [cPointer] inSmalltalk: [interpreterProxy cCoerce: cPointer to: #'unsigned int *']) at: zeroBasedDigitIndex)