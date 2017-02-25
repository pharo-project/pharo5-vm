header access
rtRefCountOf: obj put: refCount
	"Set the rt reference count of obj; this is the three bit field comprised
	 of isGrey,isPinned,isRemembered.  See computeRefCountToShrinkRT."
	| header |
	self assert: (refCount between: 0 and: MaxRTRefCount).
	header := self longAt: obj.
	header := header bitAnd: (7 << self rememberedBitShift) bitInvert64.
	header := header + (refCount << self rememberedBitShift).
	self longAt: obj put: header