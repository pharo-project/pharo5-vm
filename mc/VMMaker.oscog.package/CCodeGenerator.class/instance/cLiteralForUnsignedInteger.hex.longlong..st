C code generator
cLiteralForUnsignedInteger: anInteger hex: aBoolean longlong: llBoolean
	"Answer the string for generating an unsigned literal integer.
	Use hexadecimal notation as prescribed by aBoolean.
	Force long long suffix (LL) if the integer does not fit on 32 bits, or if llBoolean is true."
	
	| printString |
	printString := aBoolean
		ifTrue: [anInteger positive
			ifTrue: ['0x' , (anInteger printStringBase: 16)]
			ifFalse: ['-0x' , (anInteger negated printStringBase: 16)]]
		ifFalse: [anInteger printString].
	^anInteger positive
		ifTrue: [(llBoolean or: [anInteger > 16rFFFFFFFF "UINT_MAX"])
			ifTrue: [printString , 'ULL']
			ifFalse: [printString , 'U']]
		ifFalse: [self error: 'please provide positive integer']