snapshot
imageSizeToWrite
	"Answer the number of bytes that will be written to
	 the image file in a snapshot, excluding the header."
	^freeStart - self startOfMemory