inner loop
warpLoop
	"This version of the inner loop traverses an arbirary quadrilateral
	source, thus producing a general affine transformation."
	| skewWord halftoneWord mergeWord startBits
	  deltaP12x deltaP12y deltaP43x deltaP43y pAx pAy pBx pBy
	  xDelta yDelta smoothingCount sourceMapOop
	  nSteps nPix words destWord endBits mergeFnwith dstShiftInc dstShiftLeft mapperFlags |
	<inline: false>	
	<var: #mergeFnwith declareC: 'unsigned int (*mergeFnwith)(unsigned int, unsigned int)'>
	<var: #skewWord type: #'unsigned int'>
	<var: #halftoneWord type: #'unsigned int'>
	<var: #mergeWord type: #'unsigned int'>
	<var: #destWord type: #'unsigned int'>
	mergeFnwith := self cCoerce: (opTable at: combinationRule+1) to: 'unsigned int (*)(unsigned int, unsigned int)'.
	mergeFnwith.  "null ref for compiler"

	(interpreterProxy slotSizeOf: bitBltOop) >= (BBWarpBase+12)
		ifFalse: [^ interpreterProxy primitiveFail].
	nSteps := height-1.  nSteps <= 0 ifTrue: [nSteps := 1].

	pAx := self fetchIntOrFloat: BBWarpBase ofObject: bitBltOop.
	words := self fetchIntOrFloat: BBWarpBase+3 ofObject: bitBltOop.
	deltaP12x := self deltaFrom: pAx to: words nSteps: nSteps.
	deltaP12x < 0 ifTrue: [pAx := words - (nSteps*deltaP12x)].

	pAy := self fetchIntOrFloat: BBWarpBase+1 ofObject: bitBltOop.
	words := self fetchIntOrFloat: BBWarpBase+4 ofObject: bitBltOop.
	deltaP12y := self deltaFrom: pAy to: words nSteps: nSteps.
	deltaP12y < 0 ifTrue: [pAy := words - (nSteps*deltaP12y)].

	pBx := self fetchIntOrFloat: BBWarpBase+9 ofObject: bitBltOop.
	words := self fetchIntOrFloat: BBWarpBase+6 ofObject: bitBltOop.
	deltaP43x := self deltaFrom: pBx to: words nSteps: nSteps.
	deltaP43x < 0 ifTrue: [pBx := words - (nSteps*deltaP43x)].

	pBy := self fetchIntOrFloat: BBWarpBase+10 ofObject: bitBltOop.
	words := self fetchIntOrFloat: BBWarpBase+7 ofObject: bitBltOop.
	deltaP43y := self deltaFrom: pBy to: words nSteps: nSteps.
	deltaP43y < 0 ifTrue: [pBy := words - (nSteps*deltaP43y)].

	interpreterProxy failed ifTrue: [^ false].  "ie if non-integers above"
	interpreterProxy methodArgumentCount = 2
		ifTrue: [smoothingCount := interpreterProxy stackIntegerValue: 1.
				sourceMapOop := interpreterProxy stackValue: 0.
				sourceMapOop = interpreterProxy nilObject
				ifTrue: [sourceDepth < 16 ifTrue:
					["color map is required to smooth non-RGB dest"
					^ interpreterProxy primitiveFail]]
				ifFalse: [(interpreterProxy slotSizeOf: sourceMapOop)
							< (1 << sourceDepth) ifTrue:
					["sourceMap must be long enough for sourceDepth"
					^ interpreterProxy primitiveFail].
					sourceMapOop := self oopForPointer: (interpreterProxy firstIndexableField: sourceMapOop)]]
		ifFalse: [smoothingCount := 1.
				sourceMapOop := interpreterProxy nilObject].
	nSteps := width-1.  nSteps <= 0 ifTrue: [nSteps := 1].
	startBits := destPPW - (dx bitAnd: destPPW-1).
	endBits := ((dx + bbW - 1) bitAnd: destPPW-1) + 1.
 	bbW < startBits ifTrue:[startBits := bbW].

	destY < clipY ifTrue:[
		"Advance increments if there was clipping in y"
		pAx := pAx + (clipY - destY * deltaP12x).
		pAy := pAy + (clipY - destY * deltaP12y).
		pBx := pBx + (clipY - destY * deltaP43x).
		pBy := pBy + (clipY - destY * deltaP43y)].

	"Setup values for faster pixel fetching."
	self warpLoopSetup.
	"Setup color mapping if not provided"
	(smoothingCount > 1 and:[(cmFlags bitAnd: ColorMapNewStyle) = 0]) ifTrue:[
		cmLookupTable == nil ifTrue:[
			destDepth = 16 ifTrue:[self setupColorMasksFrom: 8 to: 5].
		] ifFalse:[
			self setupColorMasksFrom: 8 to: cmBitsPerColor.
		].
	].
	mapperFlags := cmFlags bitAnd: ColorMapNewStyle bitInvert32.

	destMSB
		ifTrue:[	dstShiftInc := 0 - destDepth.
				dstShiftLeft := 32 - destDepth]
		ifFalse:[	dstShiftInc := destDepth.
				dstShiftLeft := 0].
	1 to: bbH do:
		[ :i | "here is the vertical loop..."
		xDelta := self deltaFrom: pAx to: pBx nSteps: nSteps.
 		xDelta >= 0 ifTrue: [sx := pAx] ifFalse: [sx := pBx - (nSteps*xDelta)].
		yDelta := self deltaFrom: pAy to: pBy nSteps: nSteps.
 		yDelta >= 0 ifTrue: [sy := pAy] ifFalse: [sy := pBy - (nSteps*yDelta)].

		destMSB
			ifTrue:[dstBitShift := 32 - ((dx bitAnd: destPPW - 1) + 1 * destDepth)]
			ifFalse:[dstBitShift := (dx bitAnd: destPPW - 1) * destDepth].

		(destX < clipX) ifTrue:[
			"Advance increments if there was clipping in x"
			sx := sx + (clipX - destX * xDelta).
			sy := sy + (clipX - destX * yDelta).
		].

		noHalftone
			ifTrue: [halftoneWord := AllOnes]
			ifFalse: [halftoneWord := self halftoneAt: dy+i-1].
		destMask := mask1.
		nPix := startBits.
		"Here is the inner loop..."
		words := nWords.
			["pick up word"
			smoothingCount = 1 ifTrue:["Faster if not smoothing"
				skewWord := self warpPickSourcePixels: nPix
								xDeltah: xDelta yDeltah: yDelta
								xDeltav: deltaP12x yDeltav: deltaP12y
								dstShiftInc: dstShiftInc flags: mapperFlags.
			] ifFalse:["more difficult with smoothing"
				skewWord := self warpPickSmoothPixels: nPix
						xDeltah: xDelta yDeltah: yDelta
						xDeltav: deltaP12x yDeltav: deltaP12y
						sourceMap: sourceMapOop
						smoothing: smoothingCount
						dstShiftInc: dstShiftInc.
			].
			"align next word access to left most pixel"
			dstBitShift := dstShiftLeft.
			destMask = AllOnes ifTrue:["avoid read-modify-write"
				mergeWord := self mergeFn: (skewWord bitAnd: halftoneWord)
								with: (self dstLongAt: destIndex).
				self dstLongAt: destIndex put: (destMask bitAnd: mergeWord).
			] ifFalse:[ "General version using dest masking"
				destWord := self dstLongAt: destIndex.
				mergeWord := self mergeFn: (skewWord bitAnd: halftoneWord)
								with: (destWord bitAnd: destMask).
				destWord := (destMask bitAnd: mergeWord) bitOr:
								(destWord bitAnd: destMask bitInvert32).
				self dstLongAt: destIndex put: destWord.
			].
			self incDestIndex: 4.
			words = 2 "e.g., is the next word the last word?"
				ifTrue:["set mask for last word in this row"
						destMask := mask2.
						nPix := endBits]
				ifFalse:["use fullword mask for inner loop"
						destMask := AllOnes.
						nPix := destPPW].
			(words := words - 1) = 0] whileFalse.
		"--- end of inner loop ---"
		pAx := pAx + deltaP12x.
		pAy := pAy + deltaP12y.
		pBx := pBx + deltaP43x.
		pBy := pBy + deltaP43y.
		self incDestIndex: destDelta]