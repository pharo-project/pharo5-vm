segments
initSegmentBridgeWithBytes: numBytes at: address
	<var: #numBytes type: #usqLong>
	| numSlots |
	"must have room for a double header"
	self assert: (numBytes \\ self allocationUnit = 0
				 and: [numBytes >= (self baseHeaderSize + self baseHeaderSize)]).
	numSlots := numBytes - self baseHeaderSize - self baseHeaderSize >> self shiftForWord.
	self flag: #endianness.
	numSlots = 0
		ifTrue: "short bridge for adjacent segments"
			[self longAt: address put: (1 << self pinnedBitShift)
									+ (self wordIndexableFormat << self formatShift)
									+ self segmentBridgePun;
				longAt: address + 4 put: (1 << self markedBitHalfShift)]
		ifFalse: "long bridge"
			[self longAt: address put: numSlots;
				longAt: address + 4 put: self numSlotsMask << self numSlotsHalfShift;
				longAt: address + 8 put: (1 << self pinnedBitShift)
										+ (self wordIndexableFormat << self formatShift)
										+ self segmentBridgePun;
				longAt: address + 12 put: self numSlotsMask << self numSlotsHalfShift
										+ (1 << self markedBitHalfShift)]