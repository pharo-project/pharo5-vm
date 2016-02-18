contexts
badContextSize: oop
	| numSlots |
	numSlots := self numSlotsOf: oop.
	^numSlots ~= SmallContextSlots and: [numSlots ~= LargeContextSlots]