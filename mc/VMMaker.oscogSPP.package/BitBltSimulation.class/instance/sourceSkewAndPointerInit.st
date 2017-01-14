setup
sourceSkewAndPointerInit
	"This is only used when source and dest are same depth,
	ie, when the barrel-shift copy loop is used."
	| dWid sxLowBits dxLowBits pixPerM1 |
	<inline: true>
	pixPerM1 := destPPW - 1.  "A mask, assuming power of two"
	sxLowBits := sx bitAnd: pixPerM1.
	dxLowBits := dx bitAnd: pixPerM1.
	"check if need to preload buffer
	(i.e., two words of source needed for first word of destination)"
	hDir > 0 ifTrue:
		["n Bits stored in 1st word of dest"
		dWid := bbW min: destPPW - dxLowBits.
		preload := (sxLowBits + dWid) > pixPerM1]
	ifFalse:
		[dWid := bbW min: dxLowBits + 1.
		preload := (sxLowBits - dWid + 1) < 0].

	"calculate right-shift skew from source to dest"
	sourceMSB
		ifTrue:[skew := (sxLowBits - dxLowBits) * destDepth] 
		ifFalse:[skew := (dxLowBits - sxLowBits) * destDepth].  " -32..32 "
	preload ifTrue: 
		[skew < 0
			ifTrue: [skew := skew+32]
			ifFalse: [skew := skew-32]].

	"Calc byte addr and delta from longWord info"
	sourceIndex := sourceBits + (sy * sourcePitch) + ((sx // (32//sourceDepth)) *4).
	"calculate increments from end of 1 line to start of next"
	sourceDelta := (sourcePitch * vDir) - (4 * (nWords * hDir)).

	preload ifTrue:
		["Compensate for extra source word fetched"
		sourceDelta := sourceDelta - (4*hDir)].