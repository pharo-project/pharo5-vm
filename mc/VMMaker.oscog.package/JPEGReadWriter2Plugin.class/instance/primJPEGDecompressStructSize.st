primitives
primJPEGDecompressStructSize
	<export: true>

	self
		primitive: 'primJPEGDecompressStructSize'
		parameters: #().

	^(self cCode: 'sizeof(struct jpeg_decompress_struct)' inSmalltalk: [0])
		asOop: SmallInteger