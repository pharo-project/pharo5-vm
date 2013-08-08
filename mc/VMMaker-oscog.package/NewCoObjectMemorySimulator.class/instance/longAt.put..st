memory access
longAt: byteAddress put: a32BitValue
	"(byteAddress = 16r1896A50
	and: [a32BitValue = 7]) ifTrue:
		[self halt]."
	"Note: Adjusted for Smalltalk's 1-based array indexing."
	byteAddress \\ 4 ~= 0 ifTrue: [self error: 'unaligned access'].
	^memory at: (byteAddress // 4) + 1 put: a32BitValue