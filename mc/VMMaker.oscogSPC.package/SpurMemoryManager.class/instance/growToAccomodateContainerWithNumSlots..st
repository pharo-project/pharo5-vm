growing/shrinking memory
growToAccomodateContainerWithNumSlots: numSlots
	"Grow memory to accomodate a container (an Array) with numSlots.
	 Grow by at least the growHeadroom.  Supports allInstancesOf: and allObjects."
	| delta |
	delta := self baseHeaderSize * 2 + (numSlots * self bytesPerOop).
	self growOldSpaceByAtLeast: (growHeadroom max: delta)