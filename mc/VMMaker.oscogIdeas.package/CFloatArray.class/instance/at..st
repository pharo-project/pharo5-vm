accessing
at: offset
	| address |
	address := unitSize * offset + self ptrAddress.
	^unitSize >= 4
		ifTrue:
			[unitSize = 4
				ifTrue: [Float fromIEEE32Bit: (interpreter long32At: address)]
				ifFalse: [Float fromIEEE64BitWord: (interpreter long64At: address)]]
		ifFalse:
			[self error: 'unitSize must be 4 or 8']