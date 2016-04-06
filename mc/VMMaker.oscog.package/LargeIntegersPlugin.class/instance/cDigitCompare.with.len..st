C core
cDigitCompare: pFirst with: pSecond len: len 
	"Precondition: pFirst len = pSecond len."
	| secondDigit ix firstDigit |
	<var: #pFirst type: #'unsigned int *'>
	<var: #pSecond type: #'unsigned int *'>
	<var: #firstDigit type: #'unsigned int'>
	<var: #secondDigit type: #'unsigned int'>
	ix := len - 1.
	[ix >= 0]
		whileTrue: 
			[(secondDigit := pSecond at: ix) ~= (firstDigit := pFirst at: ix)
				ifTrue: [(self byteSwapped32IfBigEndian: secondDigit) < (self byteSwapped32IfBigEndian: firstDigit)
						ifTrue: [^ 1]
						ifFalse: [^ -1]].
			ix := ix - 1].
	^ 0