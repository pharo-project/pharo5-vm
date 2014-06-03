interpreter access
fetchByte: byteIndex ofObject: oop
	<api>
	^self byteAt: oop + BaseHeaderSize + byteIndex