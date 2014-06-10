header access
hasOverflowHeader: objOop
	^(self rawNumSlotsOf: objOop) = self numSlotsMask