object access
storeShort16: shortIndex ofObject: oop withValue: value
	^self shortAt: oop + BaseHeaderSize + (shortIndex << 1) put: value