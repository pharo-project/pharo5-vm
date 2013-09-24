primitives
primitiveInflateDecompressBlock
	"Primitive. Inflate a single block."
	| oop rcvr |
	<export: true>
	interpreterProxy methodArgumentCount = 2 ifFalse:
		[^interpreterProxy primitiveFail].
	"distance table"
	oop := interpreterProxy stackValue: 0.
	(interpreterProxy isWords: oop) ifFalse:
		[^interpreterProxy primitiveFail].
	zipDistTable := interpreterProxy firstIndexableField: oop.
	zipDistTableSize := interpreterProxy slotSizeOf: oop.

	"literal table"
	oop := interpreterProxy stackValue: 1.
	(interpreterProxy isWords: oop) ifFalse:
		[^interpreterProxy primitiveFail].
	zipLitTable := interpreterProxy firstIndexableField: oop.
	zipLitTableSize := interpreterProxy slotSizeOf: oop.


	"Receiver (InflateStream)"
	rcvr := interpreterProxy stackValue: 2.
	(interpreterProxy isPointers: rcvr) ifFalse:
		[^interpreterProxy primitiveFail].
	(interpreterProxy slotSizeOf: rcvr) < 9
		ifTrue:[^interpreterProxy primitiveFail].

	"All the integer instvars"
	zipReadLimit := interpreterProxy fetchInteger: 2 ofObject: rcvr.
	zipState := interpreterProxy fetchInteger: 3 ofObject: rcvr.
	zipBitBuf := interpreterProxy fetchInteger: 4 ofObject: rcvr.
	zipBitPos := interpreterProxy fetchInteger: 5 ofObject: rcvr.
	zipSourcePos := interpreterProxy fetchInteger: 7 ofObject: rcvr.
	zipSourceLimit := interpreterProxy fetchInteger: 8 ofObject: rcvr.
	interpreterProxy failed ifTrue:[^nil].
	zipReadLimit := zipReadLimit - 1.
	zipSourcePos := zipSourcePos - 1.
	zipSourceLimit := zipSourceLimit - 1.

	"collection"
	oop := interpreterProxy fetchPointer: 0 ofObject: rcvr.
	(interpreterProxy isBytes: oop) ifFalse:
		[^interpreterProxy primitiveFail].
	zipCollection := interpreterProxy firstIndexableField: oop.
	zipCollectionSize := interpreterProxy byteSizeOf: oop.

	"source"
	oop := interpreterProxy fetchPointer: 6 ofObject: rcvr.
	(interpreterProxy isBytes: oop) ifFalse:
		[^interpreterProxy primitiveFail].
	zipSource := interpreterProxy firstIndexableField: oop.

	"do the primitive"
	self zipDecompressBlock.
	interpreterProxy failed ifFalse: "store modified values back"
		[interpreterProxy storeInteger: 2 ofObject: rcvr withValue: zipReadLimit + 1.
		interpreterProxy storeInteger: 3 ofObject: rcvr withValue: zipState.
		interpreterProxy storeInteger: 4 ofObject: rcvr withValue: zipBitBuf.
		interpreterProxy storeInteger: 5 ofObject: rcvr withValue: zipBitPos.
		interpreterProxy storeInteger: 7 ofObject: rcvr withValue: zipSourcePos + 1.
		interpreterProxy pop: 2]