primitives
primImageNumComponents: aJPEGDecompressStruct

	<export: true>

	self
		primitive: 'primImageNumComponents'
		parameters: #(ByteArray).

	"Various parameter checks"
	self cCode: '
		interpreterProxy->success
			((interpreterProxy->stSizeOf(interpreterProxy->stackValue(0))) >= (sizeof(struct jpeg_decompress_struct))); 
		if (interpreterProxy->failed()) return null;
	' inSmalltalk: [].

	^(self cCode: '((j_decompress_ptr)aJPEGDecompressStruct)->num_components' inSmalltalk: [0])
		 asOop: SmallInteger