object enumeration
isMobileObjectHeader: objHeader
	"Answer if an object with header objHeader should be moved during compaction.
	 Non-objects (free chunks & bridges), forwarders and pinned objects are excluded."
	<inline: true>
	^(objHeader >> self pinnedBitShift bitAnd: 1) = 0
	  and: [(self classIndexOfHeader: objHeader) > self isForwardedObjectClassIndexPun]