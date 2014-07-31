object access
fetchShort16: shortIndex ofObject: oop
	^self shortAt: oop + BaseHeaderSize + (shortIndex << 1)