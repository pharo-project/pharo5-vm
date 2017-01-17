object access
fetchShort16: shortIndex ofObject: oop
	^self shortAt: oop + self baseHeaderSize + (shortIndex << 1)