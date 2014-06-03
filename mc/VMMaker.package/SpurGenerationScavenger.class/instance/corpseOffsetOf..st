weakness and ephemerality
corpseOffsetOf: corpse
	"Answer the offset of the corpse in newSpace as a multiple of allocationUnits.
	 Use the identityHash and format fields to construct a 27 bit offset through
	 non-future newSpace and use this to implement lists for weak array and
	 ephemeron processing.  27 bits of 8 byte allocationUnits units is 2 ^ 30
	 bytes or 1Gb, big enough for newSpace for a good few years yet.  Add
	 one to ensure that a corpse offset is always non-zero, even when it is
	 that of the first object in newSpace."
	^corpse - manager newSpaceStart >> manager shiftForAllocationUnit + 1