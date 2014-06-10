allocation
largeObjectBytesForSlots: numSlots
	"Answer the total number of bytes in an object with an overflow header, including header bytes."
	^self baseHeaderSize + self baseHeaderSize "double header"
	+ (numSlots * self bytesPerSlot) "no rounding; bytesPerSlot = allocationUnit"