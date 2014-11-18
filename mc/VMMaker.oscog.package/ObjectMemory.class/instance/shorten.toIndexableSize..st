allocation
shorten: obj toIndexableSize: nSlots
	"Reduce the number of indexable fields in obj, a pointer object, to nSlots. Convert the
	unused residual to a free chunk. Word and byte indexable objects are not changed.
	Answer the number of bytes returned to free memory, which may be zero if no change
	was possible."
	| deltaBytes desiredLength fixedFields fmt hdr totalLength
	 indexableFields |
	(self isPointersNonImm: obj) ifFalse: [^0].
	nSlots >  0
		ifFalse: [^0]. "no change if nSlots is zero, error if nSlots is negative"
	hdr := self baseHeader: obj.
	fmt := self formatOfHeader: hdr.
	totalLength := self lengthOf: obj baseHeader: hdr format: fmt.
	fixedFields := self fixedFieldsOf: obj format: fmt length: totalLength.
	indexableFields := totalLength - fixedFields.
	nSlots >= indexableFields
		ifTrue: [^0]. "no change, or error if attempting to increase size into next chunk"
	desiredLength := fixedFields + nSlots.		
	deltaBytes := (totalLength - desiredLength) * self wordSize.
	self setSizeOfFree: obj + self baseHeaderSize + (desiredLength * self wordSize)
		to: deltaBytes.
	(self headerType: obj) caseOf:	{
		[HeaderTypeSizeAndClass] ->
			[self longAt: (obj - (self baseHeaderSize * 2)) put: (self sizeHeader: obj) - deltaBytes].
		[HeaderTypeClass] ->
			[self longAt: obj put: ((hdr bitClear: SizeMask) bitOr: (hdr bitAnd: SizeMask) - deltaBytes)].
		[HeaderTypeShort] ->
			[self longAt: obj put: ((hdr bitClear: SizeMask) bitOr: (hdr bitAnd: SizeMask) - deltaBytes)] }.
	^deltaBytes