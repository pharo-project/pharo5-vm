header format
headerForSlots: numSlots hash: hash format: formatField classIndex: classIndex
	"The header format in LSB is
	 MSB:	| 8: numSlots		| (on a byte boundary)
			| 2 bits				|	(msb,lsb = {isMarked,?})
			| 22: identityHash	| (on a word boundary)
			| 3 bits				|	(msb <-> lsb = {isGrey,isPinned,isRemembered}
			| 5: format			| (on a byte boundary)
			| 2 bits				|	(msb,lsb = {isImmutable,?})
			| 22: classIndex		| (on a word boundary) : LSB
	 The remaining bits (7) are used for
		isImmutable	(bit 23)
		isRemembered	(bit 29)
		isPinned		(bit 30)
		isGrey			(bit 31)
		isMarked		(bit 55)
	 leaving 2 unused bits, each next to a 22-bit field, allowing those fields to be
	 expanded to 23 bits..  The three bit field { isGrey, isPinned, isRemembered }
	 is for bits that are never set in young objects.  This allows the remembered
	 table to be pruned when full by using these bits as a reference count of
	 newSpace objects from the remembered table. Objects with a high count
	 should be tenured to prune the remembered table."
	<returnTypeC: #usqLong>
	<inline: true>
	^ ((self cCoerceSimple: numSlots to: #usqLong) << self numSlotsFullShift)
	+ ((self cCoerceSimple: hash to: #usqLong) << self identityHashFullWordShift)
	+ (formatField << self formatShift)
	+ classIndex