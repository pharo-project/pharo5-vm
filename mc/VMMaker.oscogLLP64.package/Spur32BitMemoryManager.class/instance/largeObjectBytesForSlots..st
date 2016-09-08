allocation
largeObjectBytesForSlots: numSlots
	"Answer the total number of bytes in an object with an overflow header, including header bytes."
	<returnTypeC: #usqInt>
	^self baseHeaderSize + self baseHeaderSize "double header"
	+ (numSlots + (numSlots bitAnd: 1) * self bytesPerOop) "roundTo allocationUnit"