accessing
objectHeader: aValue
	^baseHeaderSize = 8
		ifTrue: [memory long64At: address + 1 put: aValue]
		ifFalse: [memory longAt: address + 1 put: aValue]