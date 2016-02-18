gc - scavenging
rtRefCountOf: obj
	"Answer the rt reference count of obj; this is the three bit field comprised
	 of isGrey,isPinned,isRemembered.  See computeRefCountToShrinkRT."
	^(self longAt: obj) >> self rememberedBitShift bitAnd: MaxRTRefCount