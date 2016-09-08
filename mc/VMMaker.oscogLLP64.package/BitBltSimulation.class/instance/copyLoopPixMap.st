inner loop
copyLoopPixMap
	"This version of the inner loop maps source pixels
	to a destination form with different depth.  Because it is already
	unweildy, the loop is not unrolled as in the other versions.
	Preload, skew and skewMask are all overlooked, since pickSourcePixels
	delivers its destination word already properly aligned.
	Note that pickSourcePixels could be copied in-line at the top of
	the horizontal loop, and some of its inits moved out of the loop."
	"ar 12/7/1999:
	The loop has been rewritten to use only one pickSourcePixels call.
	The idea is that the call itself could be inlined. If we decide not
	to inline pickSourcePixels we could optimize the loop instead."
	| skewWord halftoneWord mergeWord scrStartBits nSourceIncs startBits endBits sourcePixMask destPixMask mergeFnwith nPix srcShift dstShift destWord words srcShiftInc dstShiftInc dstShiftLeft mapperFlags |
	<inline: false>
	<var: #mergeFnwith declareC: 'unsigned int (*mergeFnwith)(unsigned int, unsigned int)'>
	<var: #skewWord type: #'unsigned int'>
	<var: #halftoneWord type: #'unsigned int'>
	<var: #mergeWord type: #'unsigned int'>
	<var: #destWord type: #'unsigned int'>
	<var: #sourcePixMask type: #'unsigned int'>
	<var: #destPixMask type: #'unsigned int'>
	mergeFnwith := self cCoerce: (opTable at: combinationRule+1) to: 'unsigned int (*)(unsigned int, unsigned int)'.
	mergeFnwith.  "null ref for compiler"

	"Additional inits peculiar to unequal source and dest pix size..."
	sourcePPW := 32//sourceDepth.
	sourcePixMask := maskTable at: sourceDepth.
	destPixMask := maskTable at: destDepth.
	mapperFlags := cmFlags bitAnd: ColorMapNewStyle bitInvert32.
	sourceIndex := sourceBits +
					(sy * sourcePitch) + ((sx // sourcePPW) *4).
	scrStartBits := sourcePPW - (sx bitAnd: sourcePPW-1).
	bbW < scrStartBits
		ifTrue: [nSourceIncs := 0]
		ifFalse: [nSourceIncs := (bbW - scrStartBits)//sourcePPW + 1].
	sourceDelta := sourcePitch - (nSourceIncs * 4).

	"Note following two items were already calculated in destmask setup!"
	startBits := destPPW - (dx bitAnd: destPPW-1).
	endBits := ((dx + bbW - 1) bitAnd: destPPW-1) + 1.

	bbW < startBits ifTrue:[startBits := bbW].

	"Precomputed shifts for pickSourcePixels"
	srcShift := ((sx bitAnd: sourcePPW - 1) * sourceDepth).
	dstShift := ((dx bitAnd: destPPW - 1) * destDepth).
	srcShiftInc := sourceDepth.
	dstShiftInc := destDepth.
	dstShiftLeft := 0.
	sourceMSB ifTrue:[
		srcShift := 32 - sourceDepth - srcShift.
		srcShiftInc := 0 - srcShiftInc].
	destMSB ifTrue:[
		dstShift := 32 - destDepth - dstShift.
		dstShiftInc := 0 - dstShiftInc.
		dstShiftLeft := 32 - destDepth].

	1 to: bbH do: "here is the vertical loop"
		[ :i |
		"*** is it possible at all that noHalftone == false? ***"
		noHalftone
			ifTrue:[halftoneWord := AllOnes]
			ifFalse: [halftoneWord := self halftoneAt: dy+i-1].
		"setup first load"
		srcBitShift := srcShift.
		dstBitShift := dstShift.
		destMask := mask1.
		nPix := startBits.
		"Here is the horizontal loop..."
		words := nWords.
			["pick up the word"
			skewWord := self pickSourcePixels: nPix flags: mapperFlags 
								srcMask: sourcePixMask destMask: destPixMask
								srcShiftInc: srcShiftInc dstShiftInc: dstShiftInc.
			"align next word to leftmost pixel"
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
		self incSrcIndex: sourceDelta.
		self incDestIndex: destDelta]
