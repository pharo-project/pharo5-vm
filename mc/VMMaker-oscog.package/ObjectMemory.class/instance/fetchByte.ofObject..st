interpreter access
fetchByte: byteIndex ofObject: oop

	^ self byteAt: oop + BaseHeaderSize + byteIndex