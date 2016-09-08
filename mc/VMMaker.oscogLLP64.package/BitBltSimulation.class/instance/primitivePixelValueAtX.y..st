primitives
primitivePixelValueAtX: xVal y: yVal
	"returns the single pixel at x@y.
	It does not handle LSB bitmaps right now.
	If x or y are < 0, return 0 to indicate transparent (cf BitBlt>bitPeekerFromForm: usage).
	Likewise if x>width or y>depth.
	Fail if the rcvr doesn't seem to be a Form, or x|y seem wrong"
	| rcvr bitmap depth ppW stride bitsSize word mask shift pixel |
	rcvr := self primitive: 'primitivePixelValueAt' parameters: #(SmallInteger SmallInteger) receiver: #Oop.
	
	"possible quick exit if x or y is -ve"
	(xVal < 0 or: [ yVal < 0 ] ) ifTrue:[^interpreterProxy integerObjectOf: 0].
	"check that rcvr is plausibly a Form or subclass"	
	rcvr := interpreterProxy stackValue: interpreterProxy methodArgumentCount.
	((interpreterProxy isPointers: rcvr) and: [(interpreterProxy slotSizeOf: rcvr) >= 4])
		ifFalse: [^interpreterProxy primitiveFail].

	"get the bits oop and width/height/depth"
	bitmap := interpreterProxy fetchPointer: FormBitsIndex ofObject: rcvr.
	(interpreterProxy isWordsOrBytes: bitmap) ifFalse: [^interpreterProxy primitiveFail].
	width := interpreterProxy fetchInteger: FormWidthIndex ofObject: rcvr.
	height := interpreterProxy fetchInteger: FormHeightIndex ofObject: rcvr.
	depth := interpreterProxy fetchInteger: FormDepthIndex ofObject: rcvr.
	"if width/height/depth are not integer, fail"
	interpreterProxy failed ifTrue:[^nil].

	"possible quick exit if x or y is >= extent of form. This also catches cases where the width/height are < 0"
	(xVal >= width or: [ yVal >= height ] ) ifTrue:[^interpreterProxy integerObjectOf: 0].

	"we don't handle LSB Forms yet"
	depth < 0 ifTrue:[^interpreterProxy primitiveFail].
	
	"OK so now we know we have a plausible Form, the width/height/depth/x/y are all reasonable and it's time to plunder the bitmap"
	ppW := 32//depth. "pixels in each word"
	stride := (width + (ppW  -1)) // ppW. "how many words per row of pixels"
	bitsSize := interpreterProxy byteSizeOf: bitmap.
	bitsSize >= (stride * height * 4 "bytes per word")
		ifFalse: [^interpreterProxy primitiveFail].
	word := interpreterProxy fetchLong32:(yVal * stride) + (xVal//ppW) ofObject: bitmap. "load the word that contains our target"
	mask := 16rFFFFFFFF >> (32 - depth). "make a mask to isolate the pixel within that word"
	shift := 32 - (((xVal bitAnd: ppW-1) + 1) * depth). "this is the tricky MSB part - we mask the xVal to find how far into the word we need, then add 1 for the pixel we're looking for, then * depth to get the bit shift"
	pixel := (word >> shift) bitAnd: mask. "shift, mask and dim the lights"
	^ pixel asPositiveIntegerObj "pop the incoming and push our answer"
