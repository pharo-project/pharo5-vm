gc - scavenging
newSpaceRefCountMask
	"The three bit field { isGrey, isPinned, isRemembered } is for bits
	 that are never set in young objects.  This allows the remembered
	 table to be pruned when full by using these bits as a reference
	 count of newSpace objects from the remembered table. Objects
	 with a high count should be tenured to prune the remembered table."
	^1 << self greyBitShift
	  bitOr: (1 << self pinnedBitShift
	  bitOr: 1 << self rememberedBitShift)