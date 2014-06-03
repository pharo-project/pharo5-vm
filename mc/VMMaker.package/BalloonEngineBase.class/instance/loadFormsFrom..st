loading state
loadFormsFrom: arrayOop
	"Check all the forms from arrayOop."
	| formOop bmBits bmBitsSize bmWidth bmHeight bmDepth ppw bmRaster |
	(interpreterProxy isArray: arrayOop) ifFalse:[^false].
	formArray := arrayOop.
	0 to: (interpreterProxy slotSizeOf: formArray) - 1 do:[:i|
		formOop := interpreterProxy fetchPointer: i ofObject: formArray.
		(interpreterProxy isPointers: formOop) ifFalse:[^false].
		(interpreterProxy slotSizeOf: formOop) < 5 ifTrue:[^false].
		bmBits := interpreterProxy fetchPointer: 0 ofObject: formOop.
		(interpreterProxy fetchClassOf: bmBits) = interpreterProxy classBitmap
			ifFalse:[^false].
		bmBitsSize := interpreterProxy slotSizeOf: bmBits.
		bmWidth := interpreterProxy fetchInteger: 1 ofObject: formOop.
		bmHeight := interpreterProxy fetchInteger: 2 ofObject: formOop.
		bmDepth := interpreterProxy fetchInteger: 3 ofObject: formOop.
		interpreterProxy failed ifTrue:[^false].
		(bmWidth >= 0 and:[bmHeight >= 0]) ifFalse:[^false].
		ppw := 32 // bmDepth.
		bmRaster := bmWidth + (ppw-1) // ppw.
		bmBitsSize = (bmRaster * bmHeight)
			ifFalse:[^false].
	].
	^true