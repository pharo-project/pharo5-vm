object access
numBytesOf: objOop 
	"Answer the number of indexable bytes in the given non-immediate object.
	 Does not adjust the size of contexts by stackPointer."
	<api>
	| header sz fmt |
	header := self baseHeader: objOop.
	sz := (header bitAnd: TypeMask) = HeaderTypeSizeAndClass
			ifTrue: [(self sizeHeader: objOop) bitAnd: AllButTypeMask]
			ifFalse: [header bitAnd: SizeMask].
	fmt := self formatOfHeader: header.
	^fmt < self firstByteFormat
		ifTrue: [(sz - self baseHeaderSize)]  "words"
		ifFalse: [(sz - self baseHeaderSize) - (fmt bitAnd: 3)]  "bytes"