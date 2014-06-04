interpreter access
storeByte: byteIndex ofObject: oop withValue: valueByte

	^ self byteAt: oop + BaseHeaderSize + byteIndex
		put: valueByte