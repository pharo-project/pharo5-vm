primitives
primJPEGCompressStructSize
	<export: true>

	self
		primitive: 'primJPEGCompressStructSize'
		parameters: #().

	^(self cCode: 'sizeof(struct jpeg_compress_struct)' inSmalltalk: [0])
		asOop: SmallInteger