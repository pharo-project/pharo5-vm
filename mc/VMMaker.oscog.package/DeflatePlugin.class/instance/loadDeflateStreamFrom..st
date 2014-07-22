primitive support
loadDeflateStreamFrom: rcvr
	| oop |
	<inline: false>
	((interpreterProxy isPointers: rcvr)
	 and: [(interpreterProxy slotSizeOf: rcvr) >= 15]) ifFalse:
		[^false].
	oop := interpreterProxy fetchPointer: 0 ofObject: rcvr.
	(interpreterProxy isBytes: oop) ifFalse:
		[^false].
	writeStreamInstSize = 0 ifTrue:
		[(self determineSizeOfWriteStream: rcvr) ifFalse:
			[^false].
		 "If the receiver wasn't valid then we derived writeStreamInstSize from an invalid source.  discard it."
		 (interpreterProxy slotSizeOf: rcvr) < (writeStreamInstSize + 5) ifTrue:
			[writeStreamInstSize := 0.
			 ^false]].
	zipCollection := interpreterProxy firstIndexableField: oop.
	zipCollectionSize := interpreterProxy byteSizeOf: oop.

	zipPosition := interpreterProxy fetchInteger: 1 ofObject: rcvr.
	zipReadLimit := interpreterProxy fetchInteger: 2 ofObject: rcvr.
	"zipWriteLimit := interpreterProxy fetchInteger: 3 ofObject: rcvr."

	oop := interpreterProxy fetchPointer: writeStreamInstSize + 0 ofObject: rcvr.
	((interpreterProxy isWords: oop)
	 and: [(interpreterProxy slotSizeOf: oop) = DeflateHashTableSize]) ifFalse:
		[^false].
	zipHashHead := interpreterProxy firstIndexableField: oop.
	oop := interpreterProxy fetchPointer: writeStreamInstSize + 1 ofObject: rcvr.
	((interpreterProxy isWords: oop)
	 and: [(interpreterProxy slotSizeOf: oop) = DeflateWindowSize]) ifFalse:
		[^false].
	zipHashTail := interpreterProxy firstIndexableField: oop.
	zipHashValue := interpreterProxy fetchInteger: writeStreamInstSize + 2 ofObject: rcvr.
	zipBlockPos := interpreterProxy fetchInteger: writeStreamInstSize + 3 ofObject: rcvr.
	"zipBlockStart := interpreterProxy fetchInteger: writeStreamInstSize + 4 ofObject: rcvr."
	oop := interpreterProxy fetchPointer: writeStreamInstSize + 5 ofObject: rcvr.
	(interpreterProxy isBytes: oop) ifFalse:
		[^false].
	zipLiteralSize := interpreterProxy slotSizeOf: oop.
	zipLiterals := interpreterProxy firstIndexableField: oop.

	oop := interpreterProxy fetchPointer: writeStreamInstSize + 6 ofObject: rcvr.
	((interpreterProxy isWords: oop)
	 and: [(interpreterProxy slotSizeOf: oop) >= zipLiteralSize]) ifFalse:
		[^false].
	zipDistances := interpreterProxy firstIndexableField: oop.

	oop := interpreterProxy fetchPointer: writeStreamInstSize + 7 ofObject: rcvr.
	((interpreterProxy isWords: oop)
	 and: [(interpreterProxy slotSizeOf: oop) = DeflateMaxLiteralCodes]) ifFalse:
		[^false].
	zipLiteralFreq := interpreterProxy firstIndexableField: oop.

	oop := interpreterProxy fetchPointer: writeStreamInstSize + 8 ofObject: rcvr.
	((interpreterProxy isWords: oop)
	 and: [(interpreterProxy slotSizeOf: oop) = DeflateMaxDistanceCodes]) ifFalse:
		[^false].
	zipDistanceFreq := interpreterProxy firstIndexableField: oop.

	zipLiteralCount := interpreterProxy fetchInteger: writeStreamInstSize + 9 ofObject: rcvr.
	zipMatchCount := interpreterProxy fetchInteger: writeStreamInstSize + 10 ofObject: rcvr.

	^interpreterProxy failed not