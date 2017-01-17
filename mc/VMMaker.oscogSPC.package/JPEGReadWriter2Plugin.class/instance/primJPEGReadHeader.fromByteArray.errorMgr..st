primitives
primJPEGReadHeader: aJPEGDecompressStruct fromByteArray: source errorMgr: aJPEGErrorMgr2Struct
	
	| sourceSize |
	
	<export: true>
	
	self
		primitive: 'primJPEGReadHeaderfromByteArrayerrorMgr'
		parameters: #(ByteArray ByteArray ByteArray).

	"Various parameter checks"
	interpreterProxy success: 
		(self cCode: 'interpreterProxy->stSizeOf(interpreterProxy->stackValue(2)) >= (sizeof(struct jpeg_decompress_struct))' inSmalltalk: []).
	interpreterProxy success:
		(self cCode: 'interpreterProxy->stSizeOf(interpreterProxy->stackValue(0)) >= (sizeof(struct error_mgr2))' inSmalltalk: []).
	interpreterProxy failed ifTrue: [ ^ nil ].
	
	sourceSize := interpreterProxy stSizeOf: (interpreterProxy stackValue: 1).
	sourceSize > 0 ifTrue:
		[self primJPEGReadHeader: aJPEGDecompressStruct
			fromByteArray: source
			size: sourceSize
			errorMgrReadHeader: aJPEGErrorMgr2Struct]