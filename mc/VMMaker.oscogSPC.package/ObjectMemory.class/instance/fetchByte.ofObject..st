object access
fetchByte: byteIndex ofObject: oop
	<api>
	^self byteAt: oop + self baseHeaderSize + byteIndex