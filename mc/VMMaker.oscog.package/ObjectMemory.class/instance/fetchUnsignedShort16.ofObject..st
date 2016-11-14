object access
fetchUnsignedShort16: shortIndex ofObject: oop
	^self cCoerceSimple: (self shortAt: oop + self baseHeaderSize + (shortIndex << 1)) to: #'unsigned short'