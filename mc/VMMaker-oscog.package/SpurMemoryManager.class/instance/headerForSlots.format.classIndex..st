header format
headerForSlots: numSlots format: formatField classIndex: classIndex 
	"The header format in LSB is
	 MSB:	| 8: numSlots		| (on a byte boundary)
			| 2 bits				|
			| 22: identityHash	| (on a word boundary)
			| 3 bits				|	(msb <-> lsb = ?,?,isRemembered
			| 5: format			| (on a byte boundary)
			| 2 bits				|
			| 22: classIndex		| (on a word boundary) : LSB
	 The remaining bits (7) need to be used for
		isGrey
		isMarked
		isRemembered (bit 29)
		isPinned
		isImmutable
	 leaving 2 unused bits."
	<returnTypeC: #usqLong>
	^ (numSlots << self numSlotsFullShift)
	+ (formatField << self formatShift)
	+ classIndex