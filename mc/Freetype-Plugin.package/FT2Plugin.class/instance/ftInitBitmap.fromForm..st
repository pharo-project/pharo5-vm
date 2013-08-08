private
ftInitBitmap: bitmap fromForm: formOop
	"Initialize the values in an FT_Bitmap from the given Form"
	| width height depth buffer pitch numGrays pixelMode wordsPerRow |
	self returnTypeC: 'int'.
	self var: #bitmap type: 'FT_Bitmap*'.
	self var: #buffer type: 'unsigned char*'.

	interpreterProxy success: formOop isPointers.
	interpreterProxy success: (interpreterProxy slotSizeOf: formOop) >= FormInstSize.
	interpreterProxy failed ifTrue: [^nil].

	width := interpreterProxy fetchInteger: FormWidthIndex ofObject: formOop.
	height := interpreterProxy fetchInteger: FormHeightIndex ofObject: formOop.
	depth := interpreterProxy fetchInteger: FormDepthIndex ofObject: formOop.
	buffer := self cCoerce: (interpreterProxy fetchArray: FormBitsIndex ofObject: formOop) to: 'void*'.
	interpreterProxy failed ifTrue: [^nil].

	depth < 0 ifTrue: [ depth := depth * -1].

	depth = 1 ifTrue: [
		wordsPerRow := (width + 31) // 32.
		numGrays := 1.
		pixelMode := self cCode: 'FT_PIXEL_MODE_MONO' inSmalltalk: [1].
		] ifFalse: [
	depth = 8 ifTrue: [
		wordsPerRow := (width + 3) // 4. 
		numGrays := 256.
		pixelMode := self cCode: 'FT_PIXEL_MODE_GRAY' inSmalltalk: [2].
	] ifFalse: [^interpreterProxy primitiveFail]].


	self ifNotDefined: 'WORDS_BIGENDIAN' then: [
		depth := depth * -1.
	].
	interpreterProxy storeInteger: FormDepthIndex ofObject: formOop withValue: depth.
	
	pitch := wordsPerRow * 4.

	self cCode: 'bitmap->rows = height' inSmalltalk: [self touch: height].
	self cCode: 'bitmap->width = width' inSmalltalk: [self touch: width].
	self cCode: 'bitmap->pitch = pitch' inSmalltalk: [self touch: pitch].
	self cCode: 'bitmap->buffer = buffer' inSmalltalk: [self touch: buffer].
	self cCode: 'bitmap->num_grays = numGrays' inSmalltalk: [self touch: numGrays].
	self cCode: 'bitmap->pixel_mode = pixelMode' inSmalltalk: [self touch: pixelMode].

	^true "unused"