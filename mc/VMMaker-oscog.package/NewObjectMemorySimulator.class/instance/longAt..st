memory access
longAt: byteAddress
	"Note: Adjusted for Smalltalk's 1-based array indexing."
	byteAddress \\ 4 ~= 0 ifTrue: [self error: 'unaligned access'].
	^memory at: (byteAddress // 4) + 1