weakness and ephemerality
nextCorpseOffset: corpse
	"Answer the offset of the next corpse to corpse, which is zero if none.
	 Use the identityHash and format fields to construct a 27 bit offset through
	 non-future newSpace and use this to implement lists for weak array and
	 ephemeron processing.  27 bits of 8 byte allocationUnits units is 2 ^ 30 bytes
	 or 1Gb, big enough for newSpace for a good few years yet."
	^(manager rawHashBitsOf: corpse) << manager formatFieldWidthShift
	 + (manager formatOf: corpse)