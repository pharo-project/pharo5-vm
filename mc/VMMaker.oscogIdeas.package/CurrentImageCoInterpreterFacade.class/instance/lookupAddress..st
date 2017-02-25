labels
lookupAddress: address
	| thing |
	thing := objectMap
				keyAtValue: address
				ifAbsent:
					[variables
						keyAtValue: address
						ifAbsent: [^nil]].
	^(thing isLiteral
		ifTrue: [thing storeString]
		ifFalse: [thing asString]) contractTo: 64