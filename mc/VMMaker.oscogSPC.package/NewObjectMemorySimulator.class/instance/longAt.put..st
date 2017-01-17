memory access
longAt: byteAddress put: a32BitValue
	"Note: Adjusted for Smalltalk's 1-based array indexing."
	byteAddress \\ 4 ~= 0 ifTrue: [self unalignedAccessError].
	^memory at: byteAddress // 4 + 1 put: a32BitValue