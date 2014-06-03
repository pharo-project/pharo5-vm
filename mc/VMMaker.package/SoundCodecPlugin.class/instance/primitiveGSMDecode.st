gsm 6.10 codec
primitiveGSMDecode

	| dstIndex dst srcIndex src frameCount state srcSize dstSize result srcDelta dstDelta |
	<export: true>
	dstIndex := interpreterProxy stackIntegerValue: 0.
	dst := interpreterProxy stackValue: 1.
	srcIndex := interpreterProxy stackIntegerValue: 2.
	src := interpreterProxy stackValue: 3.
	frameCount := interpreterProxy stackIntegerValue: 4.
	state := interpreterProxy stackValue: 5.
	interpreterProxy success: (interpreterProxy isWords: dst).
	interpreterProxy success: (interpreterProxy isBytes: src).
	interpreterProxy success: (interpreterProxy isBytes: state).
	interpreterProxy failed ifTrue:[^ nil].
	srcSize := interpreterProxy slotSizeOf: src.
	dstSize := (interpreterProxy slotSizeOf: dst) * 2.
	self cCode: 'gsmDecode(state + BaseHeaderSize, frameCount, src, srcIndex, srcSize, dst, dstIndex, dstSize, &srcDelta, &dstDelta)'.
	interpreterProxy failed ifTrue:[^ nil].
	result := interpreterProxy makePointwithxValue: srcDelta yValue: dstDelta.
	interpreterProxy failed ifTrue:[^ nil].
	interpreterProxy pop: 6 thenPush: result