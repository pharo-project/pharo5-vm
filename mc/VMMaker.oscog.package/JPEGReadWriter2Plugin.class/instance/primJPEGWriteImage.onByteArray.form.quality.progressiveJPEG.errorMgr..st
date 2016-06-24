primitives
primJPEGWriteImage: aJPEGCompressStruct onByteArray: destination form: form quality: quality progressiveJPEG: progressiveFlag errorMgr: aJPEGErrorMgr2Struct

	| formBitmap formWidth formHeight formNativeDepth formDepth destinationSize pixelsPerWord wordsPerRow formPitch formBitmapSizeInBytes formBitmapOOP formComponentBitSize formComponents |
	<export: true>
	<var: #formBitmap type: 'unsigned int *'> 
	<var: #destinationSize type: 'unsigned int'>

	self
		primitive: 'primJPEGWriteImageonByteArrayformqualityprogressiveJPEGerrorMgr'
		parameters: #(ByteArray ByteArray Form SmallInteger Boolean ByteArray).

	formBitmapOOP := interpreterProxy fetchPointer: 0 ofObject: form.
	formWidth := interpreterProxy fetchInteger: 1 ofObject: form.
	formHeight := interpreterProxy fetchInteger: 2 ofObject: form.
	formNativeDepth := interpreterProxy fetchInteger: 3 ofObject: form.
	formDepth := formNativeDepth abs.

	"Various parameter checks"
	interpreterProxy success:
		(self cCode: 'interpreterProxy->stSizeOf(interpreterProxy->stackValue(5)) >= (sizeof(struct jpeg_compress_struct))' inSmalltalk: []).
	interpreterProxy success: 
		(self cCode: 'interpreterProxy->stSizeOf(interpreterProxy->stackValue(0)) >= (sizeof(struct error_mgr2))' inSmalltalk: []).
	interpreterProxy failed ifTrue: [ ^ nil ].
	
	formComponents := formDepth ~= 8 ifTrue: [4] ifFalse: [1].
	formComponentBitSize := formDepth ~= 16 ifTrue: [8] ifFalse: [4].
	pixelsPerWord := 32 // (formComponents * formComponentBitSize).
	wordsPerRow := (formWidth + pixelsPerWord - 1) // pixelsPerWord.
	formPitch := wordsPerRow * 4.
	formBitmapSizeInBytes := interpreterProxy byteSizeOf: formBitmapOOP.
	interpreterProxy success: 
		((interpreterProxy isWordsOrBytes: formBitmapOOP) and: 
		[formBitmapSizeInBytes >= (formPitch * formHeight)]).
	interpreterProxy failed ifTrue: [ ^ nil ].
	
	formBitmap := interpreterProxy firstIndexableField: formBitmapOOP.
	destinationSize := interpreterProxy stSizeOf: (interpreterProxy stackValue: 4).
	(destinationSize = 0) 
		ifFalse: [ self 
			cCode: ' primJPEGWriteImageonByteArrayformqualityprogressiveJPEGerrorMgrWriteScanlines(
				formWidth, 
				formHeight, 
				formNativeDepth, 
				formBitmap, 
				aJPEGCompressStruct,
				aJPEGErrorMgr2Struct,
				quality,
				progressiveFlag,
				pixelsPerWord, 
				wordsPerRow, 
				destination,
				&destinationSize);'
			inSmalltalk: []].
	
	^(self cCode: 'destinationSize' inSmalltalk: [0])
		asOop: SmallInteger