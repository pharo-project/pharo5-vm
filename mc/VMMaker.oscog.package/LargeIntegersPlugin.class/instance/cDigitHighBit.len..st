C core util
cDigitHighBit: pUint32 len: len 
	"Answer the index (in bits) of the high order bit of the receiver, or zero if the    
	 receiver is zero. This method is allowed (and needed) for     
	LargeNegativeIntegers as well, since Squeak's LargeIntegers are sign/magnitude.
	Work with 32 bits digits."
	| realLength lastDigit |
	<var: #pUint32 type: #'unsigned int *'>
	<var: #lastDigit type: #'unsigned int'>
	realLength := len.
	[realLength = 0 ifTrue: [^0].
	(lastDigit := self cDigitOf: pUint32 at: (realLength := realLength - 1)) = 0]
		whileTrue.
	^  (self cHighBit32: lastDigit) + (32 * realLength)