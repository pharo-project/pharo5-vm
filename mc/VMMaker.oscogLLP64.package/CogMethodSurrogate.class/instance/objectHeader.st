accessing
objectHeader
	^baseHeaderSize = 8
		ifTrue: [memory long64At: address + 1]
		ifFalse: [memory longAt: address + 1]