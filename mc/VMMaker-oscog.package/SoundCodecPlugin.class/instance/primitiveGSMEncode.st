gsm 6.10 codec
primitiveGSMEncode

	| dstIndex dst srcIndex src frameCount state srcSize dstSize result srcDelta dstDelta |
	<export: true>
	dstIndex := interpreterProxy stackIntegerValue: 0.
	dst := interpreterProxy stackObjectValue: 1.
	srcIndex := interpreterProxy stackIntegerValue: 2.
	src := interpreterProxy stackObjectValue: 3.
	frameCount := interpreterProxy stackIntegerValue: 4.
	state := interpreterProxy stackObjectValue: 5.
	interpreterProxy success: (interpreterProxy isBytes: dst).
	interpreterProxy success: (interpreterProxy isWords: src).
	interpreterProxy success: (interpreterProxy isBytes: state).
	interpreterProxy failed ifTrue:[^ nil].
	srcSize := (interpreterProxy slotSizeOf: src) * 2.
	dstSize := interpreterProxy slotSizeOf: dst.
	self cCode: 'gsmEncode(state + 4, frameCount, src, srcIndex, srcSize, dst, dstIndex, dstSize, &srcDelta, &dstDelta)'.
	interpreterProxy failed ifTrue:[^ nil].
	result := interpreterProxy makePointwithxValue: srcDelta yValue: dstDelta.
	interpreterProxy failed ifTrue:[^ nil].
	interpreterProxy pop: 6.
	interpreterProxy push: result.
