free space
initFreeChunkWithBytes: numBytes at: address
	<var: #numBytes type: #usqLong>
	| numSlots |
	"must have room for a header (single or double) plus the next free pointer"
	self assert: (numBytes \\ self allocationUnit = 0
				 and: [numBytes >= (self baseHeaderSize + self bytesPerOop)]).
	self flag: #endianness.
	"double header"
	numBytes >= ((self numSlotsMask << self shiftForWord) + self baseHeaderSize) ifTrue:
		[numSlots := numBytes - self baseHeaderSize - self baseHeaderSize >> self shiftForWord.
		 self longAt: address put: numSlots;
			longAt: address + 4 put: self numSlotsMask << self numSlotsHalfShift;
			longAt: address + 8 put: 0; "0's classIndex; 0 = classIndex of free chunks"
			longAt: address + 12 put: self numSlotsMask << self numSlotsHalfShift.
		^address + 8].
	"single header"
	numSlots := numBytes - self baseHeaderSize >> self shiftForWord.
	self assert: numSlots < self numSlotsMask.
	self longAt: address put: 0; "0's classIndex; 0 = classIndex of free chunks"
		longAt: address + 4 put: numSlots << self numSlotsHalfShift.
	^address