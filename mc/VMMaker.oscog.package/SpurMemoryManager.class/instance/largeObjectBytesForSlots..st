allocation
largeObjectBytesForSlots: numSlots
	"Answer the total number of bytes in an object with an overflow header, including header bytes."
	^self subclassResponsibility