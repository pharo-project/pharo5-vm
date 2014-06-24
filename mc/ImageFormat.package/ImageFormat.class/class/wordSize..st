instance creation
wordSize: bytesPerWord
	bytesPerWord = 4
		ifTrue: [^self new fromInteger: 6502].
	bytesPerWord = 8
		ifTrue: [^self new fromInteger: 68000].
	self error: 'unsupported word size ', bytesPerWord