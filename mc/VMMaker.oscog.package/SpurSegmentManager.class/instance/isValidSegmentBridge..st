testing
isValidSegmentBridge: objOop
	"bridges bridge the gaps between segments. They are the last object in each segment."
	^((manager addressCouldBeObj: objOop) or: [objOop = manager endOfMemory])
	  and: [(manager isSegmentBridge: objOop)
	  and: [(manager hasOverflowHeader: objOop)
		or: [(manager numSlotsOfAny: objOop) = 0]]]