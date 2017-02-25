image save/restore
putLong: n toFile: f
	"Append the given 4-byte long word to the given file in my byte order. (Bytes will be swapped, if necessary, when the image is read on a different platform.) Set successFlag to false if the write fails."

	f
		nextPut: (n bitShift: -24);
		nextPut: ((n bitShift: -16) bitAnd: 16rFF);
		nextPut: ((n bitShift: -8) bitAnd: 16rFF);
		nextPut: (n bitAnd: 16rFF).

	self success: true