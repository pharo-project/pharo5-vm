fills-bitmaps
loadBitmapFill: formOop colormap: cmOop tile: tileFlag from: point1 along: point2 normal: point3 xIndex: xIndex
	"Load the bitmap fill."
	| bmFill cmSize cmBits bmBits bmBitsSize bmWidth bmHeight bmDepth ppw bmRaster |
	<var: #cmBits type: #'int *'>
	<var: #point1 type: #'int *'>
	<var: #point2 type: #'int *'>
	<var: #point3 type: #'int *'>

	cmOop == interpreterProxy nilObject ifTrue:[
		cmSize := 0.
		cmBits := nil.
	] ifFalse:[
		(interpreterProxy fetchClassOf: cmOop) = interpreterProxy classBitmap
			ifFalse:[^interpreterProxy primitiveFail].
		cmSize := interpreterProxy slotSizeOf: cmOop.
		cmBits := interpreterProxy firstIndexableField: cmOop.
	].
	(interpreterProxy isPointers: formOop) 
		ifFalse:[^interpreterProxy primitiveFail].
	(interpreterProxy slotSizeOf: formOop) < 5 
		ifTrue:[^interpreterProxy primitiveFail].
	bmBits := interpreterProxy fetchPointer: 0 ofObject: formOop.
	(interpreterProxy fetchClassOf: bmBits) = interpreterProxy classBitmap
		ifFalse:[^interpreterProxy primitiveFail].
	bmBitsSize := interpreterProxy slotSizeOf: bmBits.
	bmWidth := interpreterProxy fetchInteger: 1 ofObject: formOop.
	bmHeight := interpreterProxy fetchInteger: 2 ofObject: formOop.
	bmDepth := interpreterProxy fetchInteger: 3 ofObject: formOop.
	interpreterProxy failed ifTrue:[^nil].
	(bmWidth >= 0 and:[bmHeight >= 0]) ifFalse:[^interpreterProxy primitiveFail].
	(bmDepth = 32) | (bmDepth = 8) | (bmDepth = 16) | 
		(bmDepth = 1) | (bmDepth = 2) | (bmDepth = 4)
			ifFalse:[^interpreterProxy primitiveFail].
	(cmSize = 0 or:[cmSize = (1 << bmDepth)])
		ifFalse:[^interpreterProxy primitiveFail].
	ppw := 32 // bmDepth.
	bmRaster := bmWidth + (ppw-1) // ppw.
	bmBitsSize = (bmRaster * bmHeight)
		ifFalse:[^interpreterProxy primitiveFail].
	bmFill := self allocateBitmapFill: cmSize colormap: cmBits.
	engineStopped ifTrue:[^nil].
	self bitmapWidthOf: bmFill put: bmWidth.
	self bitmapHeightOf: bmFill put: bmHeight.
	self bitmapDepthOf: bmFill put: bmDepth.
	self bitmapRasterOf: bmFill put: bmRaster.
	self bitmapSizeOf: bmFill put: bmBitsSize.
	self bitmapTileFlagOf: bmFill put: tileFlag.
	self objectIndexOf: bmFill put: xIndex.
	self loadFillOrientation: bmFill
		from: point1 along: point2 normal: point3
		width: bmWidth height: bmHeight.
	^bmFill