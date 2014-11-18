interpreter access
instantiateClass: classPointer indexableSize: size
	"NOTE: This method supports the backward-compatible split instSize field of the 
	class format word. The sizeHiBits will go away and other shifts change by 2 
	when the split fields get merged in an (incompatible) image change."
	<api>
	| hash header1 header2 cClass byteSize format binc header3 hdrSize sizeHiBits bm1 classFormat |
	<inline: false>
	self assert: size >= 0. "'cannot have a negative indexable field count"
	hash := self newObjectHash.
	classFormat := self formatOfClass: classPointer.
	"Low 2 bits are 0"
	header1 := (classFormat bitAnd: 16r1FF00) bitOr: (hash bitAnd: HashMaskUnshifted) << HashBitsOffset.
	header2 := classPointer.
	sizeHiBits := (classFormat bitAnd: 16r60000) >> 9.
	cClass := header1 bitAnd: CompactClassMask. "compact class field from format word"
	byteSize := (classFormat bitAnd: SizeMask + Size4Bit) + sizeHiBits.
		"size in bytes -- low 2 bits are 0"
	"Note this byteSize comes from the format word of the class which is pre-shifted
		to 4 bytes per field.  Need another shift for 8 bytes per word..."
	byteSize := byteSize << (self shiftForWord-2).
	format := self formatOfHeader: classFormat.
	self flag: #sizeLowBits.
	format < self firstByteFormat
		ifTrue:
			[format = self firstLongFormat
				ifTrue: "long32 bitmaps"
					[bm1 := self wordSize-1.
					byteSize := byteSize + (size * 4) + bm1 bitAnd: LongSizeMask. "round up"
					binc := bm1 - ((size * 4) + bm1 bitAnd: bm1). "odd bytes"
					"extra low bit (4) for 64-bit VM goes in 4-bit (betw hdr bits and sizeBits)"
					header1 := header1 bitOr: (binc bitAnd: 4)]
				ifFalse: "Arrays and 64-bit bitmaps"
					[byteSize := byteSize + (size * self wordSize)]]
		ifFalse:
			["Strings and Methods"
			bm1 := self wordSize-1.
			byteSize := byteSize + size + bm1 bitAnd: LongSizeMask. "round up"
			binc := bm1 - (size + bm1 bitAnd: bm1). "odd bytes"
			"low bits of byte size go in format field"
			header1 := header1 bitOr: (binc bitAnd: 3) << self instFormatFieldLSB.
			"extra low bit (4) for 64-bit VM goes in 4-bit (betw hdr bits and sizeBits)"
			header1 := header1 bitOr: (binc bitAnd: 4)].
	byteSize > 255 "requires size header word/full header"
		ifTrue: [header3 := byteSize. hdrSize := 3]
		ifFalse: [header1 := header1 bitOr: byteSize. hdrSize := cClass = 0 ifTrue: [2] ifFalse: [1]].
	^self allocate: byteSize headerSize: hdrSize h1: header1 h2: header2 h3: header3 doFill: true format: format