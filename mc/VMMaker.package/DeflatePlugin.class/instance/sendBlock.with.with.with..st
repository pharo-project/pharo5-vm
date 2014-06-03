encoding
sendBlock: literalStream with: distanceStream with: litTree with: distTree
	"Require: 
		zipCollection, zipCollectionSize, zipPosition,
		zipBitBuf, zipBitPos.
	"
	| oop litPos litLimit litArray distArray lit dist sum llBitLengths llCodes distBitLengths distCodes code extra litBlCount distBlCount |
	<var: #litArray type: #'unsigned char *'>
	<var: #distArray type: #'unsigned int *'>
	<var: #llBitLengths type: #'unsigned int *'>
	<var: #llCodes type: #'unsigned int *'>
	<var: #distBitLengths type: #'unsigned int *'>
	<var: #distCodes type: #'unsigned int *'>
	oop := interpreterProxy fetchPointer: 0 ofObject: literalStream.
	litPos := interpreterProxy fetchInteger: 1 ofObject: literalStream.
	litLimit := interpreterProxy fetchInteger: 2 ofObject: literalStream.
	(litPos <= litLimit
	 and: [(interpreterProxy isBytes: oop)
	 and: [litLimit <= (interpreterProxy byteSizeOf: oop)]]) ifFalse:
		[^interpreterProxy primitiveFail].
	litArray := interpreterProxy firstIndexableField: oop.

	oop := interpreterProxy fetchPointer: 0 ofObject: distanceStream.
	((interpreterProxy isWords: oop)
	 and: [litLimit <= (interpreterProxy slotSizeOf: oop)
	 and: [(interpreterProxy fetchInteger: 1 ofObject: distanceStream) = litPos
	 and: [(interpreterProxy fetchInteger: 2 ofObject: distanceStream) = litLimit]]]) ifFalse:
		[^interpreterProxy primitiveFail].
	distArray := interpreterProxy firstIndexableField: oop.

	oop := interpreterProxy fetchPointer: 0 ofObject: litTree.
	(interpreterProxy isWords: oop) ifFalse:
		[^interpreterProxy primitiveFail].
	litBlCount := interpreterProxy slotSizeOf: oop.
	llBitLengths := interpreterProxy firstIndexableField: oop.

	oop := interpreterProxy fetchPointer: 1 ofObject: litTree.
	((interpreterProxy isWords: oop)
	 and: [litBlCount = (interpreterProxy slotSizeOf: oop)]) ifFalse:
		[^interpreterProxy primitiveFail].
	llCodes := interpreterProxy firstIndexableField: oop.

	oop := interpreterProxy fetchPointer: 0 ofObject: distTree.
	(interpreterProxy isWords: oop) ifFalse:
		[^interpreterProxy primitiveFail].
	distBlCount := interpreterProxy slotSizeOf: oop.
	distBitLengths := interpreterProxy firstIndexableField: oop.

	oop := interpreterProxy fetchPointer: 1 ofObject: distTree.
	((interpreterProxy isWords: oop)
	 and: [distBlCount = (interpreterProxy slotSizeOf: oop)]) ifFalse:
		[^interpreterProxy primitiveFail].
	distCodes := interpreterProxy firstIndexableField: oop.

	self nextZipBits: 0 put: 0. "Flush pending bits if necessary"
	sum := 0.
	[litPos < litLimit and:[zipPosition + 4 < zipCollectionSize]] whileTrue:[
		lit := litArray at: litPos.
		dist := distArray at: litPos.
		litPos := litPos + 1.
		dist = 0 ifTrue:["literal"
			sum := sum + 1.
			lit < litBlCount ifFalse:[^interpreterProxy primitiveFail].
			self nextZipBits: (llBitLengths at: lit) put: (llCodes at: lit).
		] ifFalse:["match"
			sum := sum + lit + DeflateMinMatch.
			lit < 256 ifFalse:[^interpreterProxy primitiveFail].
			code := zipMatchLengthCodes at: lit.
			code < litBlCount ifFalse:[^interpreterProxy primitiveFail].
			self nextZipBits: (llBitLengths at: code) put: (llCodes at: code).
			extra := zipExtraLengthBits at: code - 257.
			extra = 0 ifFalse:[
				lit := lit - (zipBaseLength at: code - 257).
				self nextZipBits: extra put: lit].
			dist := dist - 1.
			dist < 16r8000 ifFalse:[^interpreterProxy primitiveFail].
			dist < 256
				ifTrue:[code := zipDistanceCodes at: dist]
				ifFalse:[code := zipDistanceCodes at: 256 + (dist >> 7)].
			code < distBlCount ifFalse:[^interpreterProxy primitiveFail].
			self nextZipBits: (distBitLengths at: code) put: (distCodes at: code).
			extra := zipExtraDistanceBits at: code.
			extra = 0 ifFalse:[
				dist := dist - (zipBaseDistance at: code).
				self nextZipBits: extra put: dist].
		].
	].
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy storeInteger: 1 ofObject: literalStream withValue: litPos.
	interpreterProxy storeInteger: 1 ofObject: distanceStream withValue: litPos.
	^sum