memory access
integerAt: byteAddress
	"Note: Adjusted for Smalltalk's 1-based array indexing."

	^memory integerAt: (byteAddress // 4) + 1