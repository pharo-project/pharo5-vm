image save/restore
byteSwapByteObjects
	"Byte-swap the words of all bytes objects in the image. This returns these objects to their original byte ordering after blindly byte-swapping the entire image."

	self byteSwapByteObjectsFrom: self firstObject to: endOfMemory