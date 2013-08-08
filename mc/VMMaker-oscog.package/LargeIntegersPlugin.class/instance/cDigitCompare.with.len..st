C core
cDigitCompare: pFirst with: pSecond len: len 
	"Precondition: pFirst len = pSecond len."
	| secondDigit ix firstDigit |
	<var: #pFirst type: 'unsigned char * '>
	<var: #pSecond type: 'unsigned char * '>
	ix := len - 1.
	[ix >= 0]
		whileTrue: 
			[(secondDigit := pSecond at: ix) ~= (firstDigit := pFirst at: ix)
				ifTrue: [secondDigit < firstDigit
						ifTrue: [^ 1]
						ifFalse: [^ -1]].
			ix := ix - 1].
	^ 0