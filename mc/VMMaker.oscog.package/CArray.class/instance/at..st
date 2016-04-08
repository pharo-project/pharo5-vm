accessing
at: offset
	| address |
	address := unitSize * offset + self ptrAddress.
	^unitSize <= 2
		ifTrue:
			[unitSize = 1
				ifTrue: [interpreter byteAt: address]
				ifFalse: [interpreter shortAt: address]]
		ifFalse:
			[unitSize = 4
				ifTrue: [interpreter long32At: address]
				ifFalse: [interpreter long64At: address]]