C code generator
cLiteralFor: anObject
	"Return a string representing the C literal value for the given object."
	anObject isNumber
		ifTrue:
			[anObject isInteger ifTrue:
				[| hex |
				 hex := (anObject > 0
								and: [(anObject >> anObject lowBit + 1) isPowerOfTwo
								and: [(anObject highBit = anObject lowBit and: [anObject > 65536])
									  or: [anObject highBit - anObject lowBit >= 4]]]).
				^self cLiteralForInteger: anObject hex: hex].
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