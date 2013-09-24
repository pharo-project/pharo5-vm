indexing primitive support
byteLengthOf: obj
	"Return the number of indexable bytes in the given object.
	 This is basically a special copy of lengthOf: for BitBlt. But it is also
	 whoorishly used for the Cogit."
	<api>
	| header sz fmt |
	header := self baseHeader: obj.
	sz := (header bitAnd: TypeMask) = HeaderTypeSizeAndClass
			ifTrue: [(self sizeHeader: obj) bitAnd: AllButTypeMask]
			ifFalse: [header bitAnd: SizeMask].
	fmt := self formatOfHeader: header.
	^fmt < self firstByteFormat
		ifTrue: [(sz - BaseHeaderSize)]  "words"
		ifFalse: [(sz - BaseHeaderSize) - (fmt bitAnd: 3)]  "bytes"