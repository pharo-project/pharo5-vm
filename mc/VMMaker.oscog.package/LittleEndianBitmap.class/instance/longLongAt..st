accessing
longLongAt: byteAddress
	"memory is a Bitmap, a 32-bit indexable array of bits"
	| hiWord loWord |
	byteAddress - 1 \\ 8 ~= 0 ifTrue: [self unalignedAccessError].
	loWord := self at: byteAddress - 1 // 4 + 1.
	hiWord := self at: byteAddress - 1 // 4 + 2.
	^hiWord = 0
		ifTrue: [loWord]
		ifFalse: [(hiWord signedIntFromLong bitShift: 32) + loWord]