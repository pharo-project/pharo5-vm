primitive support
loadZipEncoderFrom: rcvr
	| oop |
	<inline: false>
	((interpreterProxy isPointers: rcvr)
	 and: [(interpreterProxy slotSizeOf: rcvr) >= 6]) ifFalse:
		[^false].
	oop := interpreterProxy fetchPointer: 0 ofObject: rcvr.
	(interpreterProxy isBytes: oop) ifFalse:
		[^interpreterProxy primitiveFail].
	zipCollection := interpreterProxy firstIndexableField: oop.
	zipCollectionSize := interpreterProxy byteSizeOf: oop.

	zipPosition := interpreterProxy fetchInteger: 1 ofObject: rcvr.
	zipReadLimit := interpreterProxy fetchInteger: 2 ofObject: rcvr.
	"zipWriteLimit := interpreterProxy fetchInteger: 3 ofObject: rcvr."
	zipBitBuf := interpreterProxy fetchInteger: 4 ofObject: rcvr.
	zipBitPos := interpreterProxy fetchInteger: 5 ofObject: rcvr.

	^interpreterProxy failed not