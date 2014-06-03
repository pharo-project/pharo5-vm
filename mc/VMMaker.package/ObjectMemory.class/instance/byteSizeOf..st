object format
byteSizeOf: oop
	<api>
	| header format size |
	(self isIntegerObject: oop) ifTrue:[^0].
	header := self baseHeader: oop.
	format := self formatOfHeader: header.
	size := (header bitAnd: TypeMask) = HeaderTypeSizeAndClass
				ifTrue: [(self sizeHeader: oop) bitAnd: LongSizeMask]
				ifFalse: [header bitAnd: SizeMask].
	size := size - (header bitAnd: Size4Bit).
	^format < self firstByteFormat
		ifTrue: [ size - BaseHeaderSize "32-bit longs"]
		ifFalse: [ (size - BaseHeaderSize) - (format bitAnd: 3) "bytes"]