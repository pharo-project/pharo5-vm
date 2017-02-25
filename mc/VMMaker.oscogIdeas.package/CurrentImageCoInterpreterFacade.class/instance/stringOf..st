accessing
stringOf: anOop
	| thing |
	thing := objectMap
				keyAtValue: anOop
				ifAbsent:
					[variables
						keyAtValue: anOop
						ifAbsent: [^nil]].
	^((thing isLiteral and: [thing isSymbol not])
		ifTrue: [thing storeString]
		ifFalse: [thing asString]) contractTo: 64