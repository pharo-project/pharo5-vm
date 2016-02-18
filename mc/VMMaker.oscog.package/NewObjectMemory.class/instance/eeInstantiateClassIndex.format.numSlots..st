interpreter access
eeInstantiateClassIndex: compactClassIndex format: objFormat numSlots: numSlots
	"Instantiate an instance of a compact class.  ee stands for execution engine and
	 implies that this allocation will *NOT* cause a GC.  N.B. the instantiated object
	 IS NOT FILLED and must be completed before returning it to Smalltalk. Since this
	 call is used in routines that do just that we are safe.  Break this rule and die in GC.
	 Result is guaranteed to be young."
	<api>
	| hash header1 header2 byteSize header3 hdrSize |
	<inline: false>
	"cannot have a negative indexable field count"
	self assert: (numSlots >= 0 and: [compactClassIndex ~= 0]).
	self assert: (objFormat < self firstByteFormat
					ifTrue: [objFormat]
					ifFalse: [objFormat bitAnd: self byteFormatMask])
				= (self instSpecOfClass: (self compactClassAt: compactClassIndex)).
	hash := self newObjectHash.
	"Low 2 bits are 0"
	header1 := (objFormat << self instFormatFieldLSB
					bitOr: compactClassIndex << 12)
					bitOr: (hash bitAnd: HashMaskUnshifted) << HashBitsOffset.
	self assert: "sizeHiBits" ((self formatOfClass: (self compactClassAt: compactClassIndex)) bitAnd: 16r60000) >> 9 = 0.
	self flag: #sizeLowBits.
	"size in bytes -- low 2 bits are 0; may need another shift if 64-bits.
	 strangely, size includes size of header, but only of single header.
	 why include header size at all?  gives us an extra word."
	byteSize := numSlots << (self shiftForWord + (self shiftForWord-2)) + self baseHeaderSize.
	(self wordSize = 8 "David, please check this!!"
	 and: [objFormat >= self firstLongFormat "32-bit longs and byte objects"
	 and: [(numSlots bitAnd: 1) ~= 0]]) ifTrue:
		["extra low bit (4) for 64-bit VM goes in 4-bit (betw hdr bits and sizeBits)"
		 header1 := header1 bitOr: 4].
	byteSize > 255 "requires size header word/full header"
		ifTrue: [header3 := byteSize. hdrSize := 3. header2 := self compactClassAt: compactClassIndex]
		ifFalse: [header1 := header1 bitOr: byteSize. hdrSize := 1].
	^self eeAllocate: byteSize headerSize: hdrSize h1: header1 h2: header2 h3: header3