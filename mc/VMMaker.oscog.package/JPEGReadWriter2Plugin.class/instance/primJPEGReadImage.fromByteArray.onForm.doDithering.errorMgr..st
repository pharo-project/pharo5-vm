primitives
primJPEGReadImage: aJPEGDecompressStruct fromByteArray: source onForm: form doDithering: ditherFlag errorMgr: aJPEGErrorMgr2Struct

	| formBitmap formNativeDepth formDepth formWidth formHeight pixelsPerWord formPitch formBitmapSizeInBytes sourceSize formBitmapOOP formComponentBitSize formComponents wordsPerRow |
	<export: true>
	<var: #formBitmap type: 'unsigned int*'>

	self
		primitive: 'primJPEGReadImagefromByteArrayonFormdoDitheringerrorMgr'
		parameters: #(ByteArray ByteArray Form Boolean ByteArray).

	formBitmapOOP := interpreterProxy fetchPointer: 0 ofObject: form. 
	formNativeDepth := interpreterProxy fetchInteger: 3 ofObject: form.
	formWidth := interpreterProxy fetchInteger: 1 ofObject: form.
	formHeight := interpreterProxy fetchInteger: 2 ofObject: form.
	formDepth := formNativeDepth abs.
	
	"Various parameter checks"
	interpreterProxy success:
		(self cCode: 'interpreterProxy->stSizeOf(interpreterProxy->stackValue(4)) >= (sizeof(struct jpeg_decompress_struct))' inSmalltalk: []).
	interpreterProxy success:
		(self cCode: 'interpreterProxy->stSizeOf(interpreterProxy->stackValue(0)) >= (sizeof(struct error_mgr2))' inSmalltalk: []).
	interpreterProxy failed ifTrue: [ ^ nil ].
	
	formComponents := formDepth ~= 8 ifTrue: [4] ifFalse: [1].
	formComponentBitSize := formDepth ~= 16 ifTrue: [8] ifFalse: [4].
	pixelsPerWord := 32 // (formComponents * formComponentBitSize).
	wordsPerRow := (formWidth + pixelsPerWord - 1) // pixelsPerWord.
	formPitch := formWidth + (pixelsPerWord-1) // pixelsPerWord * 4.
	formBitmapSizeInBytes := interpreterProxy byteSizeOf: formBitmapOOP.
	
	interpreterProxy success: 
		((interpreterProxy isWordsOrBytes: formBitmapOOP) and: 
		[formBitmapSizeInBytes >= (formPitch * formHeight)]).
	interpreterProxy failed ifTrue: [^ nil].
	
	sourceSize := interpreterProxy stSizeOf: (interpreterProxy stackValue: 3).
	
	interpreterProxy success: (sourceSize ~= 0).
	interpreterProxy failed ifTrue: [  ^ nil ].
	
	formBitmap := interpreterProxy firstIndexableField: formBitmapOOP.
	
	self 
		cCode: 'primJPEGReadImagefromByteArrayonFormdoDitheringerrorMgrReadScanlines(
			aJPEGDecompressStruct,
    			aJPEGErrorMgr2Struct,
			source,
    			sourceSize,
    			ditherFlag,
    			formBitmap,
   			pixelsPerWord,
   			wordsPerRow,
    			formNativeDepth);'
		inSmalltalk: [].