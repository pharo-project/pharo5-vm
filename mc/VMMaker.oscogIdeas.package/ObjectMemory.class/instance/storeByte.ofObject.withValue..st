object access
storeByte: byteIndex ofObject: oop withValue: valueByte

	^ self byteAt: oop + self baseHeaderSize + byteIndex
		put: valueByte