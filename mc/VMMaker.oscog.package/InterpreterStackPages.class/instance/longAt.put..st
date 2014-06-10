memory access
longAt: byteAddress put: a32BitValue
	"Note: Adjusted for Smalltalk's 1-based array indexing."
	self assert: (byteAddress bitAnd: BytesPerWord - 1) == 0.
	^stackMemory at: byteAddress // BytesPerWord + indexOffset put: a32BitValue