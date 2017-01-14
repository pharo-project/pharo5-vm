type inference
unsignedTypeForIntegralType: aCTypeString
	^aCTypeString first = $u
		ifTrue: [aCTypeString]
		ifFalse:
			[(aCTypeString beginsWith: 'sq')
				ifTrue: ['u' , aCTypeString]
				ifFalse: ['unsigned ' , aCTypeString]]