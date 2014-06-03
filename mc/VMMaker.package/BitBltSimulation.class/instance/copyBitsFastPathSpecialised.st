setup
copyBitsFastPathSpecialised
	"Perform the actual copyBits operation using the fast path specialised code; fail some cases by falling back to normal code.
	Assume: Surfaces have been locked and clipping was performed."
	<inline: false>

	self
		cppIf: #'ENABLE_FAST_BLT'
		ifTrue:[
	"set the affected area to 0 first"
	affectedL := affectedR := affectedT := affectedB := 0.
	
	self copyBitsRule41Test.	
	(interpreterProxy failed not)
		ifFalse: [^ interpreterProxy primitiveFail].

 	"we skip the tryCopyingBitsQuickly and leave that to falback code"
	 
	(combinationRule = 30) | (combinationRule = 31) ifTrue:
		["Check and fetch source alpha parameter for alpha blend"
		interpreterProxy methodArgumentCount = 1
			ifTrue: [sourceAlpha := interpreterProxy stackIntegerValue: 0.
					(interpreterProxy failed not and: [(sourceAlpha >= 0) & (sourceAlpha <= 255)])
						ifFalse: [^ interpreterProxy primitiveFail]]
			ifFalse: [^ interpreterProxy primitiveFail]].

	"we don't worry about bitCount"
	"bitCount := 0."

	"We don't  do - Choose and perform the actual copy loop."
	"self performCopyLoop."

	"this is done inversely to plain copyBitsLockedAndClipped"
	(combinationRule ~= 22) & (combinationRule ~= 32) ifTrue:
		["zero width and height; return the count"
		affectedL := dx.
		affectedR := dx + bbW.
		affectedT := dy.
		affectedB := dy + bbH].
	
	"Now we fill the 'operation' structure and pass it to the sneaky ARM code"
	self cCode:'
	// fill the operation structure
	operation_t op;
	op.combinationRule = combinationRule;
	op.noSource = noSource;
	op.src.bits = (void *) sourceBits;
	op.src.pitch = sourcePitch;
	op.src.depth = sourceDepth;
	op.src.msb = sourceMSB;
	op.src.x = sx;
	op.src.y = sy;
	op.dest.bits = (void *) destBits;
	op.dest.pitch = destPitch;
	op.dest.depth = destDepth;
	op.dest.msb = destMSB;
	op.dest.x = dx;
	op.dest.y = dy;
	op.width = bbW;
	op.height = bbH;
	op.cmFlags = cmFlags;
	op.cmShiftTable = (void *) cmShiftTable;
	op.cmMaskTable = (void *) cmMaskTable;
	op.cmMask = cmMask;
	op.cmLookupTable = (void *) cmLookupTable;
	op.noHalftone = noHalftone;
	op.halftoneHeight = halftoneHeight;
	op.halftoneBase = (void *) halftoneBase;
	if (combinationRule == 30 || combinationRule == 31) {
		op.opt.sourceAlpha = sourceAlpha;
	}
	if (combinationRule == 41) {
		op.opt.componentAlpha.componentAlphaModeColor = componentAlphaModeColor;
		op.opt.componentAlpha.componentAlphaModeAlpha = componentAlphaModeAlpha;
		op.opt.componentAlpha.gammaLookupTable = (void *) gammaLookupTable;
		op.opt.componentAlpha.ungammaLookupTable = (void *) ungammaLookupTable;
	}
	// call the sneaky code
	copyBitsDispatch(&op)'
	]