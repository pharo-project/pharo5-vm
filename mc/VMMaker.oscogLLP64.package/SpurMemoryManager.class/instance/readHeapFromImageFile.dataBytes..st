snapshot
readHeapFromImageFile: f dataBytes: numBytes
	"Read numBytes of image data from f into memory at memoryBaseForImageRead.
	 Answer the number of bytes written."
	<doNotGenerate>
	^segmentManager readHeapFromImageFile: f dataBytes: numBytes