private
loadFFTFrom: fftOop
	| oop |
	interpreterProxy success: (interpreterProxy slotSizeOf: fftOop) >= 6.
	interpreterProxy failed ifTrue:[^false].
	nu := interpreterProxy fetchInteger: 0 ofObject: fftOop.
	fftSize := interpreterProxy fetchInteger: 1 ofObject: fftOop.

	oop := interpreterProxy fetchPointer: 2 ofObject: fftOop.
	sinTableSize := interpreterProxy stSizeOf: oop.
	sinTable := self checkedFloatPtrOf: oop.

	oop := interpreterProxy fetchPointer: 3 ofObject: fftOop.
	permTableSize := interpreterProxy stSizeOf: oop.
	permTable := self checkedWordPtrOf: oop.

	oop := interpreterProxy fetchPointer: 4 ofObject: fftOop.
	realDataSize := interpreterProxy stSizeOf: oop.
	realData := self checkedFloatPtrOf: oop.

	oop := interpreterProxy fetchPointer: 5 ofObject: fftOop.
	imagDataSize := interpreterProxy stSizeOf: oop.
	imagData := self checkedFloatPtrOf: oop.

	"Check assumptions about sizes"
	interpreterProxy success:
		(1 << nu = fftSize) & 
		(fftSize // 4 + 1 = sinTableSize) & 
		(fftSize = realDataSize) & 
		(fftSize = imagDataSize) &
		(realDataSize = imagDataSize).

	^interpreterProxy failed == false