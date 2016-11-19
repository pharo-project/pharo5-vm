memory access
integerAt: byteAddress put: a32BitValue
	"Note: Adjusted for Smalltalk's 1-based array indexing."

	self deprecated.
	^objectMemory memory integerAt: (byteAddress // 4) + 1 put: a32BitValue