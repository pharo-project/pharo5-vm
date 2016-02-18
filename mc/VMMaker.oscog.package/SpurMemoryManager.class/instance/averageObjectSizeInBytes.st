accessing
averageObjectSizeInBytes
	"Answer an approximation of the average object size.  This is a bit of an underestimate.
	 In the 32-bit system average object size is about 11 words per object, including header."
	^8 * self bytesPerOop