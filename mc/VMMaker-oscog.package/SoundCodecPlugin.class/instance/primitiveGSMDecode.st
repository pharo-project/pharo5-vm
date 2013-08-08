gsm 6.10 codec
primitiveGSMDecode

	| dstIndex dst srcIndex src frameCount state srcSize dstSize result srcDelta dstDelta |
	<export: true>
	dstIndex := interpreterProxy stackIntegerValue: 0.
	dst := interpreterProxy stackObjectValue: 1.
	srcIndex := interpreterProxy stackIntegerValue: 2.
	src := interpreterProxy stackObjectValue: 3.
	frameCount := interpreterProxy stackIntegerValue: 4.
	state := interpreterProxy stackObjectValue: 5.
	interpreterProxy success: (interpreterProxy isWords: dst).
	interpreterProxy success: (interpreterProxy isBytes: src).
	interpreterProxy success: (interpreterProxy isBytes: state).
	interpreterProxy failed ifTrue:[^ nil].
	srcSize := interpreterProxy slotSizeOf: src.
	dstSize := (interpreterProxy slotSizeOf: dst) * 2.
	self cCode: 'gsmDecode(state + 4, frameCount, src, srcIndex, srcSize, dst, dstIndex, dstSize, &srcDelta, &dstDelta)'.
	interpreterProxy failed ifTrue:[^ nil].
	result := interpreterProxy makePointwithxValue: srcDelta yValue: dstDelta.
	interpreterProxy failed ifTrue:[^ nil].
	interpreterProxy pop: 6.
	interpreterProxy push: result.
