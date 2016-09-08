primitive support
loadZipEncoderFrom: rcvr
	| oop |
	<inline: false>
	writeStreamInstSize = 0 ifTrue:
		[(self determineSizeOfWriteStream: rcvr) ifFalse:
			[^false].
		 "If the receiver wasn't valid then we derived writeStreamInstSize from an invalid source.  discard it."
		 (interpreterProxy slotSizeOf: rcvr) < (writeStreamInstSize + 3) ifTrue:
			[writeStreamInstSize := 0.
			 ^false]].
	((interpreterProxy isPointers: rcvr)
	 and: [(interpreterProxy slotSizeOf: rcvr) >= (writeStreamInstSize + 3)]) ifFalse:
		[^false].
	oop := interpreterProxy fetchPointer: 0 ofObject: rcvr.
	(interpreterProxy isBytes: oop) ifFalse:
		[^interpreterProxy primitiveFail].
	zipCollection := interpreterProxy firstIndexableField: oop.
	zipCollectionSize := interpreterProxy byteSizeOf: oop.

	zipPosition := interpreterProxy fetchInteger: 1 ofObject: rcvr.
	zipReadLimit := interpreterProxy fetchInteger: 2 ofObject: rcvr.
	"zipWriteLimit := interpreterProxy fetchInteger: 3 ofObject: rcvr."
	zipBitBuf := interpreterProxy fetchInteger: writeStreamInstSize + 1 ofObject: rcvr.
	zipBitPos := interpreterProxy fetchInteger: writeStreamInstSize + 2 ofObject: rcvr.

	^interpreterProxy failed not