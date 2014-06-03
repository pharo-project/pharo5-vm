indexing primitive support
lengthOf: oop baseHeader: hdr format: fmt
	"Return the number of fixed and indexable bytes, words, or object pointers in the
	given object. Assume the given oop is not an integer. For a CompiledMethod, the size
	of the method header (in bytes) should be subtracted from the result of this method."

	| sz |
	<inline: true>
	<asmLabel: false> 
	(hdr bitAnd: TypeMask) = HeaderTypeSizeAndClass
		ifTrue: [ sz := (self sizeHeader: oop) bitAnd: LongSizeMask ]
		ifFalse: [ sz := (hdr bitAnd: SizeMask)].
	sz := sz - (hdr bitAnd: Size4Bit).
	fmt <= self lastPointerFormat
		ifTrue: [ ^ (sz - BaseHeaderSize) >> ShiftForWord "words"].
	^fmt < self firstByteFormat
		ifTrue: [(sz - BaseHeaderSize) >> 2 "32-bit longs"]
		ifFalse: [(sz - BaseHeaderSize) - (fmt bitAnd: 3) "bytes"]