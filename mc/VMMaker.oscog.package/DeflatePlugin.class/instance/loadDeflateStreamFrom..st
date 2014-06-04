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
	zipCollection := interpreterProxy firstIndexableField: oop.
	zipCollectionSize := interpreterProxy byteSizeOf: oop.

	zipPosition := interpreterProxy fetchInteger: 1 ofObject: rcvr.
	zipReadLimit := interpreterProxy fetchInteger: 2 ofObject: rcvr.
	"zipWriteLimit := interpreterProxy fetchInteger: 3 ofObject: rcvr."

	oop := interpreterProxy fetchPointer: 4 ofObject: rcvr.
	((interpreterProxy isWords: oop)
	 and: [(interpreterProxy slotSizeOf: oop) = DeflateHashTableSize]) ifFalse:
		[^false].
	zipHashHead := interpreterProxy firstIndexableField: oop.
	oop := interpreterProxy fetchPointer: 5 ofObject: rcvr.
	((interpreterProxy isWords: oop)
	 and: [(interpreterProxy slotSizeOf: oop) = DeflateWindowSize]) ifFalse:
		[^false].
	zipHashTail := interpreterProxy firstIndexableField: oop.
	zipHashValue := interpreterProxy fetchInteger: 6 ofObject: rcvr.
	zipBlockPos := interpreterProxy fetchInteger: 7 ofObject: rcvr.
	"zipBlockStart := interpreterProxy fetchInteger: 8 ofObject: rcvr."
	oop := interpreterProxy fetchPointer: 9 ofObject: rcvr.
	(interpreterProxy isBytes: oop) ifFalse:
		[^false].
	zipLiteralSize := interpreterProxy slotSizeOf: oop.
	zipLiterals := interpreterProxy firstIndexableField: oop.

	oop := interpreterProxy fetchPointer: 10 ofObject: rcvr.
	((interpreterProxy isWords: oop)
	 and: [(interpreterProxy slotSizeOf: oop) >= zipLiteralSize]) ifFalse:
		[^false].
	zipDistances := interpreterProxy firstIndexableField: oop.

	oop := interpreterProxy fetchPointer: 11 ofObject: rcvr.
	((interpreterProxy isWords: oop)
	 and: [(interpreterProxy slotSizeOf: oop) = DeflateMaxLiteralCodes]) ifFalse:
		[^false].
	zipLiteralFreq := interpreterProxy firstIndexableField: oop.

	oop := interpreterProxy fetchPointer: 12 ofObject: rcvr.
	((interpreterProxy isWords: oop)
	 and: [(interpreterProxy slotSizeOf: oop) = DeflateMaxDistanceCodes]) ifFalse:
		[^false].
	zipDistanceFreq := interpreterProxy firstIndexableField: oop.

	zipLiteralCount := interpreterProxy fetchInteger: 13 ofObject: rcvr.
	zipMatchCount := interpreterProxy fetchInteger: 14 ofObject: rcvr.

	^interpreterProxy failed not