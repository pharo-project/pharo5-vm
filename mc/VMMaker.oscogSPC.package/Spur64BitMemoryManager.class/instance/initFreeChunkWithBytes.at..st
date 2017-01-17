free space
initFreeChunkWithBytes: numBytes at: address
	<var: #numBytes type: #usqLong>
	| numSlots |
	"must have room for a header (single or double) plus the next free pointer"
	self assert: (numBytes \\ self allocationUnit = 0
				 and: [numBytes >= (self baseHeaderSize + self bytesPerOop)]).
	"double header"
	numBytes >= ((self numSlotsMask << self shiftForWord) + self baseHeaderSize) ifTrue:
		[numSlots := numBytes - self baseHeaderSize - self baseHeaderSize >> self shiftForWord.
		 self longAt: address put: self numSlotsMask << self numSlotsFullShift + numSlots;
			longAt: address + 8 put: self numSlotsMask << self numSlotsFullShift. "0's classIndex; 0 = classIndex of free chunks"
		^address + 8].
	"single header"
	numSlots := numBytes - self baseHeaderSize >> self shiftForWord.
	self assert: numSlots < self numSlotsMask.
	self longAt: address put: numSlots << self numSlotsFullShift. "0's classIndex; 0 = classIndex of free chunks"
	^address