interpreter access
eeInstantiateMethodContextByteSize: sizeInBytes 
	"This version of instantiateClass assumes that the total object 
	 size is under 256 bytes, the limit for objects with only one or 
	 two header words. Note that the size is specified in bytes 
	 and should include four bytes for the base header word.
	 Will *not* cause a GC."
	| hash header1 |
	self assert: (sizeInBytes == SmallContextSize or: [sizeInBytes == LargeContextSize]).
	self assert: sizeInBytes <= SizeMask.
	hash := self newObjectHash.
	header1 := (hash bitAnd: HashMaskUnshifted) << HashBitsOffset bitOr: self formatOfMethodContextMinusSize.
	self assert: (header1 bitAnd: CompactClassMask) > 0. "contexts must be compact"
	self assert: (header1 bitAnd: SizeMask) = 0.
	"OR size into header1.  Must not do this if size > SizeMask"
	header1 := header1 + sizeInBytes.
	^self eeAllocate: sizeInBytes headerSize: 1 h1: header1 h2: nil h3: nil