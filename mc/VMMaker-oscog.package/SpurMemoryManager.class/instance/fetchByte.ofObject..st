object access
fetchByte: byteIndex ofObject: objOop
	<api>
	^self byteAt: objOop + self baseHeaderSize + byteIndex