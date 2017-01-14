object access
fetchShort16: shortIndex ofObject: objOop
	^self shortAt: objOop + self baseHeaderSize + (shortIndex << 1)