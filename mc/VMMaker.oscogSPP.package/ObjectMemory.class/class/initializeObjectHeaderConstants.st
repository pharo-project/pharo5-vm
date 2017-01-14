initialization
initializeObjectHeaderConstants

	BytesPerWord ifNil: [BytesPerWord := 4].  "May get called on fileIn, so supply default"
	BaseHeaderSize := BytesPerWord.
	WordMask := (1 bitShift: BytesPerWord*8) - 1.
	
	"masks for type field"
	TypeMask := 3.
	AllButTypeMask := WordMask - TypeMask.

	"type field values"
	HeaderTypeSizeAndClass := 0.
	HeaderTypeClass := 1.
	HeaderTypeFree := 2.
	HeaderTypeShort := 3.
	HeaderTypeExtraBytes := { BytesPerWord * 2. BytesPerWord. 0. 0 }.

	"type field values used during the mark phase of GC"
	HeaderTypeGC := 2.
	GCTopMarker := 3.  "neither an oop, nor an oop+1, this value signals that we have crawled back up to the top of the marking phase."

	"Base header word bit fields"
	HashBits := 16r1FFE0000.
	HashBitsOffset := 17.
	HashMaskUnshifted := 16rFFF.
	self assert: (HashMaskUnshifted bitShift: HashBitsOffset) = HashBits.
	AllButHashBits := WordMask - HashBits.
	SizeMask := 16rFC.
	Size4Bit := 0.
BytesPerWord = 8 ifTrue:
		[SizeMask := 16rF8.  "Lose the 4 bit in temp 64-bit chunk format"
		Size4Bit := 4].  "But need it for ST size"
	"Note SizeMask + Size4Bit gives the mask needed for size fits of format word in classes.
		This is used in instantiateClass:indexableSize: "
	LongSizeMask := WordMask - 16rFF + SizeMask.
	LongSizeNumBits := 30. "30 bits of size info in long size filed."
	CompactClassMask := 16r1F000.

	"masks for root and mark bits"
	MarkBit := 1 bitShift: BytesPerWord*8 - 1.  "Top bit"
	RootBit := 1 bitShift: BytesPerWord*8 - 2.  "Next-to-Top bit"
	AllButMarkBit := WordMask - MarkBit.
	AllButRootBit := WordMask - RootBit.

	AllButMarkBitAndTypeMask := AllButTypeMask - MarkBit.

	ImmutabilityBit := 1 bitShift: BytesPerWord*8 - 3.  "Next-to-Next-To-Top bit"
	AllButImmutabilityBit := WordMask - ImmutabilityBit