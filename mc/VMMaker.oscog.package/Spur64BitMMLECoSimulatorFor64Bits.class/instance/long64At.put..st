memory access
long64At: byteAddress put: a64BitValue
	"memory is a DobleWordArray, a 64-bit indexable array of bits"
	byteAddress \\ 8 ~= 0 ifTrue: [self unalignedAccessError].
	^memory at: byteAddress // 8 + 1 put: a64BitValue