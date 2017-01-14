primitives
primitiveDeflateBlock
	"Primitive. Deflate the current contents of the receiver."
	| goodMatch chainLength lastIndex rcvr result |
	<export: true>
	<inline: false>
	interpreterProxy methodArgumentCount = 3
		ifFalse:[^interpreterProxy primitiveFail].
	goodMatch := interpreterProxy stackIntegerValue: 0.
	chainLength := interpreterProxy stackIntegerValue: 1.
	lastIndex := interpreterProxy stackIntegerValue: 2.
	rcvr := interpreterProxy stackObjectValue: 3.
	interpreterProxy failed ifTrue:[^nil].
	self cCode:'' inSmalltalk:[
		zipMatchLengthCodes := CArrayAccessor on: ZipWriteStream matchLengthCodes.
		zipDistanceCodes := CArrayAccessor on: ZipWriteStream distanceCodes].
	(self loadDeflateStreamFrom: rcvr)
		ifFalse:[^interpreterProxy primitiveFail].
	result := self deflateBlock: lastIndex chainLength: chainLength goodMatch: goodMatch.
	interpreterProxy failed ifFalse:[
		"Store back modified values"
		interpreterProxy storeInteger: writeStreamInstSize + 2 ofObject: rcvr withValue: zipHashValue.
		interpreterProxy storeInteger: writeStreamInstSize + 3 ofObject: rcvr withValue: zipBlockPos.
		interpreterProxy storeInteger: writeStreamInstSize + 9 ofObject: rcvr withValue: zipLiteralCount.
		interpreterProxy storeInteger: writeStreamInstSize + 10 ofObject: rcvr withValue: zipMatchCount].
	interpreterProxy failed ifFalse:[
		interpreterProxy pop: 4.
		interpreterProxy pushBool: result.
	].