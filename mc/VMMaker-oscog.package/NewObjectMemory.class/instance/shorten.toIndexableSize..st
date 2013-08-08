allocation
shorten: obj toIndexableSize: nSlots
	"Currently this works for pointer objects only, and is almost certainly wrong for 64 bits."
	| deltaBytes desiredLength fixedFields fmt hdr totalLength |
	(self isPointersNonInt: obj) ifFalse:
		[^obj].
	hdr := self baseHeader: obj.
	fmt := self formatOfHeader: hdr.
	totalLength := self lengthOf: obj baseHeader: hdr format: fmt.
	fixedFields := self fixedFieldsOf: obj format: fmt length: totalLength.
	desiredLength := fixedFields + nSlots.
	deltaBytes := (totalLength - desiredLength) * BytesPerWord.
	obj + BaseHeaderSize + (totalLength * BytesPerWord) = freeStart
		ifTrue: "Shortening the last object.  Need to reduce freeStart."
			[self maybeFillWithAllocationCheckFillerFrom: obj + BaseHeaderSize + (desiredLength * BytesPerWord) to: freeStart.
			freeStart := obj + BaseHeaderSize + (desiredLength * BytesPerWord)]
		ifFalse: "Shortening some interior object.  Need to create a free block."
			[self setSizeOfFree: obj + BaseHeaderSize + (desiredLength * BytesPerWord)
				to: deltaBytes].
	(self headerType: obj) caseOf:	{
		[HeaderTypeSizeAndClass] ->
			[self longAt: obj put: hdr - deltaBytes].
		[HeaderTypeClass] ->
			[self longAt: obj put: ((hdr bitClear: SizeMask) bitOr: (hdr bitAnd: SizeMask) - deltaBytes)].
		[HeaderTypeShort] ->
			[self longAt: obj put: ((hdr bitClear: SizeMask) bitOr: (hdr bitAnd: SizeMask) - deltaBytes)] }.
	^obj