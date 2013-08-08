testing
testCompressToByteArray

	| bitmap byteArray |
	bitmap := Bitmap with: 16rFFFFFFFF.
	byteArray := ByteArray new:  4.
	self compress: bitmap toByteArray: byteArray.
	self should: byteArray = #[1 5 255 0]