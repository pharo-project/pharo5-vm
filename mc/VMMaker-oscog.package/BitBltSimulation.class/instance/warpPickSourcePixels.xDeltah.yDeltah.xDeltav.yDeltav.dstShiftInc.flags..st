pixel mapping
warpPickSourcePixels: nPixels
	xDeltah: xDeltah yDeltah: yDeltah
	xDeltav: xDeltav yDeltav: yDeltav
	dstShiftInc: dstShiftInc
	flags: mapperFlags
	"Pick n pixels from the source form,
	map by colorMap and return aligned by dstBitShift.
	This version is only called from WarpBlt with smoothingCount = 1"
	| dstMask destWord nPix sourcePix destPix |
	<inline: true> "Yepp - this should go into warpLoop"
	dstMask := maskTable at: destDepth.
	destWord := 0.
	nPix := nPixels.
	(mapperFlags = (ColorMapPresent bitOr: ColorMapIndexedPart)) ifTrue:[
		"a little optimization for (pretty crucial) blits using indexed lookups only"
		[	"grab, colormap and mix in pixel"
			sourcePix := self pickWarpPixelAtX: sx y: sy.
			destPix := cmLookupTable at: (sourcePix bitAnd: cmMask).
			destWord := destWord bitOr: (destPix bitAnd: dstMask) << dstBitShift.
			dstBitShift := dstBitShift + dstShiftInc.
			sx := sx + xDeltah.
			sy := sy + yDeltah.
		(nPix := nPix - 1) = 0] whileFalse.
	] ifFalse:[
		[	"grab, colormap and mix in pixel"
			sourcePix := self pickWarpPixelAtX: sx y: sy.
			destPix := self mapPixel: sourcePix flags: mapperFlags.
			destWord := destWord bitOr: (destPix bitAnd: dstMask) << dstBitShift.
			dstBitShift := dstBitShift + dstShiftInc.
			sx := sx + xDeltah.
			sy := sy + yDeltah.
		(nPix := nPix - 1) = 0] whileFalse.
	].
	^destWord
