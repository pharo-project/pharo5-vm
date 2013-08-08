accessing
unsignedShortAt: byteIndex
	"Compatiblity with the ByteArray & Alien methods of the same name."
	| zi |
	^((zi := byteIndex - 1) bitAnd: 1) = 0
		ifTrue: [(zi bitAnd: 2) = 0
					ifTrue: [(self at: zi // 4 + 1) bitAnd: 16rFFFF]
					ifFalse: [(self at: zi - 2 // 4 + 1) bitShift: -16]]
		ifFalse: [(self unsignedLongAt: byteIndex bigEndian: false) bitAnd: 16rFFFF]