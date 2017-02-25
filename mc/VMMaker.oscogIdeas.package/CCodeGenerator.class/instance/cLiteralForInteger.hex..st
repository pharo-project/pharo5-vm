C code generator
cLiteralForInteger: anInteger hex: aBoolean
	"Answer the string for generating a literal integer.
	Use hexadecimal notation as prescribed by aBoolean.
	Use long long suffix (LL) if the integer does not fit on 32 bits.
	Use unsigned suffix (U) if the integer does not fit on a signed integer (resp. long long).
	Correctly generate INT_MIN and LONG_LONG_MIN.
	Indeed -0x8000000 is parsed as - (0x8000000) by C Compiler.
	0x8000000 does not fit on a signed int, it is interpreted as unsigned.
	That makes INT_MIN unsigned which is badly broken..."
	
	| printString |
	printString := aBoolean
		ifTrue: [anInteger positive
			ifTrue: ['0x' , (anInteger printStringBase: 16)]
			ifFalse: ['-0x' , (anInteger negated printStringBase: 16)]]
		ifFalse: [anInteger printString].
	^anInteger positive
		ifTrue: [anInteger > 16r7FFFFFFF "INT_MAX"
			ifTrue: [anInteger > 16rFFFFFFFF "UINT_MAX"
				ifTrue: [anInteger > 16r7FFFFFFFFFFFFFFF "LONG_LONG_MAX"
					ifTrue: [printString , 'ULL']
					ifFalse: [printString , 'LL']]
				ifFalse: [printString , 'U']]
			ifFalse: [printString]]
		ifFalse: [anInteger < -16r8000000
			ifTrue: [anInteger = -16r800000000000000	"LONG_LONG_MIN"
				ifTrue: ['(-0x7FFFFFFFFFFFFFFFLL-1)']
				ifFalse: [printString , 'LL']]
			ifFalse: [anInteger = -16r8000000	"INT_MIN"
				ifTrue: ['(-0x7FFFFFFF-1)']
				ifFalse: [printString]]]