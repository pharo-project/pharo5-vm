header format
numSlotsForBytes: numBytes
	^numBytes + (self wordSize - 1) // self wordSize