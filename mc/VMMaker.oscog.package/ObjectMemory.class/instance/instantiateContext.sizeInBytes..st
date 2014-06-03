interpreter access
instantiateContext: classPointer sizeInBytes: sizeInBytes 
	"This version of instantiateClass assumes that the total object 
	size is under 256 bytes, the limit for objects with only one or 
	two header words. Note that the size is specified in bytes 
	and should include four bytes for the base header word."
	| hash header1 header2 hdrSize |
	hash := self newObjectHash.
	header1 := (hash bitAnd: HashMaskUnshifted) << HashBitsOffset bitOr: (self formatOfClass: classPointer).
	header2 := classPointer.
	(header1 bitAnd: CompactClassMask) > 0 "are contexts compact?"
		ifTrue: [hdrSize := 1]
		ifFalse: [hdrSize := 2].
	sizeInBytes <= SizeMask
		ifTrue: ["OR size into header1.  Must not do this if size > SizeMask"
				header1 := header1 + (sizeInBytes - (header1 bitAnd: SizeMask))]
		ifFalse: [hdrSize := 3.
				"Zero the size field of header1 if large"
				header1 := header1 - (header1 bitAnd: SizeMask)].
self flag: #Dan.  "Check details of context sizes"
	^ self allocate: sizeInBytes headerSize: hdrSize h1: header1 h2: header2 h3: LargeContextSize doFill: false format: 0