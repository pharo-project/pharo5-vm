allocation
smallObjectBytesForSlots: numSlots
	"Answer the total number of bytes in an object without an overflow header, including header bytes."
	<api>
	<returnTypeC: #usqInt>
	^self baseHeaderSize "single header"
	+ (numSlots < 1
		ifTrue: [self allocationUnit] "at least one slot for the forwarding pointer"
		ifFalse: [numSlots * self bytesPerOop])