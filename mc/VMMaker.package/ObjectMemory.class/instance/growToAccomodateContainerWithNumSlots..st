allocation
growToAccomodateContainerWithNumSlots: numSlots
	"Grow memory to accomodate a container (an Array) with numSlots.
	 Grow by at least the growHeadroom.  Supports allInstancesOf: and allObjects."
	| delta |
	delta := (headerTypeBytes at: HeaderTypeSizeAndClass) / BytesPerWord
			+ 1
			+ numSlots
			* BytesPerOop.
	self growObjectMemory: (growHeadroom max: delta)