accessing
at: offset put: val
	| address |
	address := unitSize * offset + self ptrAddress.
	^unitSize >= 4
		ifTrue:
			[unitSize = 4
				ifTrue: [interpreter long32At: address put: val]
				ifFalse: [interpreter long64At: address put: val]]
		ifFalse:
			[self error: 'unitSize must be 4 or 8']