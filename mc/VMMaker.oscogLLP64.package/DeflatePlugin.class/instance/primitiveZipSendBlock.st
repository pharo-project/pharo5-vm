primitives
primitiveZipSendBlock
	| distTree litTree distStream litStream rcvr result |
	<export: true>
	interpreterProxy methodArgumentCount = 4 
		ifFalse:[^interpreterProxy primitiveFail].
	distTree := interpreterProxy stackObjectValue: 0.
	litTree := interpreterProxy stackObjectValue: 1.
	distStream := interpreterProxy stackObjectValue: 2.
	litStream := interpreterProxy stackObjectValue: 3.
	rcvr := interpreterProxy stackObjectValue: 4.
	interpreterProxy failed ifTrue:[^nil].
	(self loadZipEncoderFrom: rcvr)
		ifFalse:[^interpreterProxy primitiveFail].
	((interpreterProxy isPointers: distTree) and:[
		(interpreterProxy slotSizeOf: distTree) >= 2])
			ifFalse:[^interpreterProxy primitiveFail].
	((interpreterProxy isPointers: litTree) and:[
		(interpreterProxy slotSizeOf: litTree) >= 2])
			ifFalse:[^interpreterProxy primitiveFail].
	((interpreterProxy isPointers: litStream) and:[
		(interpreterProxy slotSizeOf: litStream) >= 3])
			ifFalse:[^interpreterProxy primitiveFail].
	((interpreterProxy isPointers: distStream) and:[
		(interpreterProxy slotSizeOf: distStream) >= 3])
			ifFalse:[^interpreterProxy primitiveFail].
	self cCode:'' inSmalltalk:[
		zipMatchLengthCodes := CArrayAccessor on: ZipWriteStream matchLengthCodes.
		zipDistanceCodes := CArrayAccessor on: ZipWriteStream distanceCodes.
		zipExtraLengthBits := CArrayAccessor on: ZipWriteStream extraLengthBits.
		zipExtraDistanceBits := CArrayAccessor on: ZipWriteStream extraDistanceBits.
		zipBaseLength := CArrayAccessor on: ZipWriteStream baseLength.
		zipBaseDistance := CArrayAccessor on: ZipWriteStream baseDistance].
	result := self sendBlock: litStream with: distStream with: litTree with: distTree.
	interpreterProxy failed ifFalse:[
		interpreterProxy storeInteger: 1 ofObject: rcvr withValue: zipPosition.
		interpreterProxy storeInteger: readStreamInstSize + 1 ofObject: rcvr withValue: zipBitBuf.
		interpreterProxy storeInteger: readStreamInstSize + 2 ofObject: rcvr withValue: zipBitPos.
	].
	interpreterProxy failed ifFalse:[
		interpreterProxy pop: 5. "rcvr + args"
		interpreterProxy pushInteger: result.
	].