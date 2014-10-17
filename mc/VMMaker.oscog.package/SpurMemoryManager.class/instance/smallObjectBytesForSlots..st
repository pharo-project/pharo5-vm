allocation
smallObjectBytesForSlots: numSlots
	"Answer the total number of bytes in an object without an overflow header, including header bytes."
	<returnTypeC: #usqInt>
	^self subclassResponsibility