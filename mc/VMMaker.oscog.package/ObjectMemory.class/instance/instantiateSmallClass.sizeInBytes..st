interpreter access
instantiateSmallClass: classPointer sizeInBytes: sizeInBytes
	"This version of instantiateClass assumes that the total object 
	size is under 256 bytes, the limit for objects with only one or 
	two header words. Note that the size is specified in bytes 
	and should include 4 or 8 bytes for the base header word. 
	NOTE this code will only work for sizes that are an integral number of words
		(like not a 32-bit LargeInteger in a 64-bit system). 
	May cause a GC.
	Note that the created small object IS NOT FILLED and must be completed before returning it to Squeak. Since this call is used in routines that do jsut that we are safe. Break this rule and die."

	| hash header1 header2 hdrSize |
	(sizeInBytes bitAnd: (self wordSize-1)) = 0 ifFalse:
		[self error: 'size must be integral number of words'].
	hash := self newObjectHash.
	header1 := (hash bitAnd: HashMaskUnshifted) << HashBitsOffset bitOr: (self formatOfClass: classPointer).
	header2 := classPointer.
	hdrSize := (header1 bitAnd: CompactClassMask) > 0 "is this a compact class"
				ifTrue: [1]
				ifFalse: [2].
	header1 := header1 + (sizeInBytes - (header1 bitAnd: SizeMask+Size4Bit)).
	^ self allocate: sizeInBytes headerSize: hdrSize h1: header1 h2: header2 h3: 0 doFill: false format: 0