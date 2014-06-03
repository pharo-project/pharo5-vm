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
		interpreterProxy storeInteger: 6 ofObject: rcvr withValue: zipHashValue.
		interpreterProxy storeInteger: 7 ofObject: rcvr withValue: zipBlockPos.
		interpreterProxy storeInteger: 13 ofObject: rcvr withValue: zipLiteralCount.
		interpreterProxy storeInteger: 14 ofObject: rcvr withValue: zipMatchCount].
	interpreterProxy failed ifFalse:[
		interpreterProxy pop: 4.
		interpreterProxy pushBool: result.
	].