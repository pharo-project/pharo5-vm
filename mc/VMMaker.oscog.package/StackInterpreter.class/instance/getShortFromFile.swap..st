image save/restore
getShortFromFile: aFile swap: swapFlag
	"Answer the next 16 bit word read from aFile, byte-swapped according to the swapFlag."

	<var: #aFile type: #sqImageFile>
	| w |
	<var: #w type: #short>
	w := 0.
	self cCode: [self
					sq: (self addressOf: w)
					Image: (self sizeof: #short)
					File: 1
					Read: aFile]
		inSmalltalk: [w := objectMemory nextShortFrom: aFile].
	^swapFlag
		ifTrue: [objectMemory byteSwapped: w]
		ifFalse: [w]