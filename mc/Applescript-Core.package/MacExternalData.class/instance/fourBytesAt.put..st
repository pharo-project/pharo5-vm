accessing
fourBytesAt: anInteger put: aString
	"Store a word corresponding to Apple's four byte code convention at anIntger"

	| str |
	aString size > 4 ifTrue: [^self error: 'string too long'].
	str := aString padded: #right to: 4 with: $ .
	self at: anInteger put: 
		(str inject: 0 into: [:val :each | val * 256 + each asciiValue])