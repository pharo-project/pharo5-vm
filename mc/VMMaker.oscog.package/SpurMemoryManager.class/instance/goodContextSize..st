object testing
goodContextSize: oop
	| numSlots |
	numSlots := self numSlotsOf: oop.
	^numSlots = SmallContextSlots or: [numSlots = LargeContextSlots]