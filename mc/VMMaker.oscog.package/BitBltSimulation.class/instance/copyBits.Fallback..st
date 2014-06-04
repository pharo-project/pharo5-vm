setup
copyBits: op Fallback: flags
	"Recover from the fast path specialised code saying Help-I-cant-cope"
	|done |
	<static: false>
	<returnTypeC: 'void'>
	<inline: false>
	<var: #op type: 'operation_t *'>
	<var: #flags type:'unsigned int'>
	self cppIf: #'ENABLE_FAST_BLT'
		ifTrue:[
			"recover values from the operation struct used by the fast ARM code"
			self cCode:'
	combinationRule = op->combinationRule;
	noSource = op->noSource;
	sourceBits = (sqInt) op->src.bits;
	sourcePitch = op->src.pitch;
	sourceDepth = op->src.depth;
	sourceMSB = op->src.msb;
	sx = op->src.x;
	sy = op->src.y;
	destBits = (sqInt) op->dest.bits;
	destPitch = op->dest.pitch;
	destDepth = op->dest.depth;
	destMSB = op->dest.msb;
	dx = op->dest.x;
	dy = op->dest.y;
	bbW = op->width;
	bbH = op->height;
	cmFlags = op->cmFlags;
	cmShiftTable = (void *) op->cmShiftTable;
	cmMaskTable = (void *) op->cmMaskTable;
	cmMask = op->cmMask;
	cmLookupTable = (void *) op->cmLookupTable;
	noHalftone = op->noHalftone;
	halftoneHeight = op->halftoneHeight;
	halftoneBase = (sqInt) op->halftoneBase;
	if (combinationRule == 30 || combinationRule == 31) {
		sourceAlpha = op->opt.sourceAlpha;
	}
	if (combinationRule == 41) {
		componentAlphaModeColor = op->opt.componentAlpha.componentAlphaModeColor;
		componentAlphaModeAlpha = op->opt.componentAlpha.componentAlphaModeAlpha;
		gammaLookupTable = (void *) op->opt.componentAlpha.gammaLookupTable;
		ungammaLookupTable = (void *) op->opt.componentAlpha.ungammaLookupTable;
	}'.
	
				destPPW := 32 / destDepth.
				cmBitsPerColor := 0.
				cmMask = 16r1FF ifTrue: [cmBitsPerColor := 3].
				cmMask = 16rFFF ifTrue: [cmBitsPerColor := 4].
				cmMask = 16r7FFF ifTrue: [cmBitsPerColor := 5].
	
				"Try a shortcut for stuff that should be run as quickly as possible"
				done := self tryCopyingBitsQuickly.
				done ifTrue:[^nil].

				bitCount := 0.
				"Choose and perform the actual copy loop."
				self performCopyLoop]

	


