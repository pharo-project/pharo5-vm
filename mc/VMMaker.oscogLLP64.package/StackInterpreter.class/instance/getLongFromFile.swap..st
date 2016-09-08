image save/restore
getLongFromFile: aFile swap: swapFlag
	"Answer the next 32 or 64 bit word read from aFile, byte-swapped according to the swapFlag."
	<var: #aFile type: #sqImageFile>
	| w |
	w := 0.
	self cCode: [self
					sq: (self addressOf: w)
					Image: (self sizeof: w)
					File: 1
					Read: aFile]
		inSmalltalk: [w := objectMemory nextLongFrom: aFile].
	^swapFlag
		ifTrue: [objectMemory byteSwapped: w]
		ifFalse: [w]