combination rules
pickSourcePixels: nPixels flags: mapperFlags srcMask: srcMask destMask: dstMask srcShiftInc: srcShiftInc dstShiftInc: dstShiftInc
	"Pick nPix pixels starting at srcBitIndex from the source, map by the
	color map, and justify them according to dstBitIndex in the resulting destWord."
	| sourceWord destWord sourcePix destPix srcShift dstShift nPix |
	<inline: true> "oh please"
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: #'unsigned int'>
	<var: #destWord type: #'unsigned int'>
	sourceWord := self srcLongAt: sourceIndex.
	destWord := 0.
	srcShift := srcBitShift. "Hint: Keep in register"
	dstShift := dstBitShift. "Hint: Keep in register"
	nPix := nPixels. "always > 0 so we can use do { } while(--nPix);"
	(mapperFlags = (ColorMapPresent bitOr: ColorMapIndexedPart)) ifTrue:[
		"a little optimization for (pretty crucial) blits using indexed lookups only"
		[	"grab, colormap and mix in pixel"
			sourcePix := sourceWord >> srcShift bitAnd: srcMask.
			destPix := cmLookupTable at: (sourcePix bitAnd: cmMask).
			destWord := destWord bitOr: (destPix bitAnd: dstMask) << dstShift.
			"adjust dest pix index"
			dstShift := dstShift + dstShiftInc.
			"adjust source pix index"
			((srcShift := srcShift + srcShiftInc) bitAnd: 16rFFFFFFE0) = 0 ifFalse:[
				sourceMSB ifTrue:[srcShift := srcShift + 32] ifFalse:[srcShift := srcShift - 32].
				sourceWord := self srcLongAt: (self incSrcIndex: 4)].
		(nPix := nPix - 1) = 0] whileFalse.
	] ifFalse:[
		[	"grab, colormap and mix in pixel"
			sourcePix := sourceWord >> srcShift bitAnd: srcMask.
			destPix := self mapPixel: sourcePix flags: mapperFlags.
			destWord := destWord bitOr: (destPix bitAnd: dstMask) << dstShift.
			"adjust dest pix index"
			dstShift := dstShift + dstShiftInc.
			"adjust source pix index"
			((srcShift := srcShift + srcShiftInc) bitAnd: 16rFFFFFFE0) = 0 ifFalse:[
				sourceMSB ifTrue:[srcShift := srcShift + 32] ifFalse:[srcShift := srcShift - 32].
				sourceWord := self srcLongAt: (self incSrcIndex: 4)].
		(nPix := nPix - 1) = 0] whileFalse.
	].
	srcBitShift := srcShift. "Store back"
	^destWord
