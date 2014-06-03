image save/restore
reverseBytesInImage
	"Byte-swap all words in memory after reading in the entire image file with bulk read. Contributed by Tim Rowledge."

	"First, byte-swap every word in the image. This fixes objects headers."
	objectMemory reverseBytesInMemory.

	"Second, return the bytes of bytes-type objects to their
	 orginal order, and perform any other format conversions."
	self updateObjectsPostByteSwap