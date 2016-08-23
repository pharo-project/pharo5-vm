accessing
at: offset put: val
	| address |
	address := unitSize * offset + self ptrAddress.
	^unitSize <= 2
		ifTrue:
			[unitSize = 1
				ifTrue: [interpreter byteAt: address put: val]
				ifFalse: [interpreter shortAt: address put: val]]
		ifFalse:
			[unitSize = 4
				ifTrue: [interpreter long32At: address put: val]
				ifFalse: [interpreter long64At: address put: val]]