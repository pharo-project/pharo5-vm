weakness and ephemerality
setCorpseOffsetOf: corpse to: offset
	"Set the offset of the corpse's next corpse to offset.  Use the identityHash
	 and format fields to construct a 27 bit offset through non-future newSpace
	 and use this to implement the list.  27 bits of 8 byte allocationUnits units is
	 2 ^ 30 bytes or 1Gb, big enough for newSpace for a good few years yet."
	<inline: true>
	self assert: (manager isYoung: corpse).
	self assert: (manager isForwarded: corpse).
	manager wordSize = 4
		ifTrue: "On 64-bit gcc 4.4.7-4 the following is miscompiled at -O2; the first assignment is lost"
			[manager
				setHashBitsOf: corpse
					to: offset >> manager formatFieldWidthShift;
				setFormatOf: corpse
					to: (offset bitAnd: manager formatMask)]
		ifFalse: "So we use the single assignment"
			[manager
				long64At: corpse
				put: (manager
						headerForSlots: (manager rawNumSlotsOf: corpse)
						hash: (offset >> manager formatFieldWidthShift)
						format: (offset bitAnd: manager formatMask)
						classIndex: manager isForwardedObjectClassIndexPun)]