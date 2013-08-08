C code generator
cLiteralFor: anObject
	"Return a string representing the C literal value for the given object."
	anObject isNumber
		ifTrue:
			[anObject isInteger ifTrue:
				[^anObject > 16rFFFFFFFF
						ifTrue: [anObject printString , ObjectMemory unsignedLongLongSuffix]
						ifFalse: [anObject < 16r7FFFFFFF
							ifTrue: [anObject printString]
							ifFalse: [anObject printString , ObjectMemory unsignedIntegerSuffix]]].
			anObject isFloat ifTrue:
				[^anObject printString]]
		ifFalse:
			[anObject isSymbol ifTrue:
				[^self cFunctionNameFor: anObject].
			anObject isString ifTrue:
				[^'"', (anObject copyReplaceAll: (String with: Character cr) with: '\n') , '"'].
			anObject == nil ifTrue: [^ 'null' ].
			anObject == true ifTrue: [^ '1' ].
			anObject == false ifTrue: [^ '0' ].
			anObject isCharacter ifTrue:
				[^anObject == $'
					ifTrue: ['''\'''''] "i.e. '\''"
					ifFalse: [anObject asString printString]]].
	self error: 'Warning: A Smalltalk literal could not be translated into a C constant: ', anObject printString.
	^'"XXX UNTRANSLATABLE CONSTANT XXX"'