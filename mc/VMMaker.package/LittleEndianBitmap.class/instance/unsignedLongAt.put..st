accessing
unsignedLongAt: byteIndex put: aValue
	"Compatiblity with the ByteArray & Alien methods of the same name."
	^(byteIndex - 1 bitAnd: 3) = 0
		ifTrue: [self at: byteIndex - 1 // 4 + 1 put: aValue]
		ifFalse: [self notYetImplemented]