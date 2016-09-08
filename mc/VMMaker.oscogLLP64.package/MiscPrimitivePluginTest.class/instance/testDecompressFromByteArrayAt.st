testing
testDecompressFromByteArrayAt

	| bitmap byteArray s size |
	byteArray := #(1 5 255  0) asByteArray.
	s := ReadStream on: byteArray.
	size := Bitmap decodeIntFrom: s.
	bitmap := Bitmap new: size.
	self decompress: bitmap fromByteArray: byteArray at: s position + 1.
	self should: bitmap = ((Bitmap new: 1) at: 1 put: 4294967295; yourself)