C core util
cDigitHighBit: pByte len: len 
	"Answer the index (in bits) of the high order bit of the receiver, or zero if the    
	 receiver is zero. This method is allowed (and needed) for     
	LargeNegativeIntegers as well, since Squeak's LargeIntegers are     
	sign/magnitude."
	| realLength lastDigit |
	<var: #pByte type: #'unsigned char *'>
	<var: #lastDigit type: #'unsigned int'>
	realLength := len.
	[(lastDigit := pByte at: realLength - 1) = 0]
		whileTrue: [(realLength := realLength - 1) = 0 ifTrue: [^ 0]].
	^  (self cHighBit: lastDigit) + (8 * (realLength - 1))