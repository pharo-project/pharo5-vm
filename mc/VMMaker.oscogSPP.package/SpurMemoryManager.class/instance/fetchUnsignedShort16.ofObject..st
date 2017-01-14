object access
fetchUnsignedShort16: shortIndex ofObject: objOop
	^self cCoerceSimple: (self shortAt: objOop + self baseHeaderSize + (shortIndex << 1)) to: #'unsigned short'