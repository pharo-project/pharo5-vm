segments
initSegmentBridgeWithBytes: numBytes at: address
	<var: #numBytes type: #usqLong>
	| numSlots |
	"must have room for a double header"
	self assert: (numBytes \\ self allocationUnit = 0
				 and: [numBytes >= (self baseHeaderSize + self baseHeaderSize)]).
	numSlots := numBytes - self baseHeaderSize - self baseHeaderSize >> self shiftForWord.
	numSlots = 0
		ifTrue: "short bridge for adjacent segments"
			[self longAt: address
					put:    (1 << self pinnedBitShift)
						+ (1 << self markedBitFullShift)
						+ (self wordIndexableFormat << self formatShift)
						+ self segmentBridgePun]
		ifFalse: "long bridge"
			[self longAt: address
					put: self numSlotsMask << self numSlotsFullShift + numSlots;
				longAt: address + self baseHeaderSize
					put: (self numSlotsMask << self numSlotsFullShift)
						+ (1 << self pinnedBitShift)
						+ (1 << self markedBitFullShift)
						+ (self wordIndexableFormat << self formatShift)
						+ self segmentBridgePun]