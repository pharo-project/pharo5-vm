C code generator
cLiteralForInteger: anInteger hex: aBoolean
	| printString |
	printString := aBoolean
		ifTrue: [anInteger positive
			ifTrue: ['0x' , anInteger printStringBase: 16]
			ifFalse: ['-0x' , anInteger negated printStringBase: 16]]
		ifFalse: [anInteger printString].
	^anInteger > 16rFFFFFFFF
			ifTrue: [printString, ObjectMemory unsignedLongLongSuffix]
			ifFalse: [anInteger < 16r7FFFFFFF
					ifTrue: [printString]
					ifFalse: [printString, ObjectMemory unsignedIntegerSuffix]]