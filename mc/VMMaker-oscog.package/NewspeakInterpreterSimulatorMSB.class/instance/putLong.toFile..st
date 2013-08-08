image save/restore
putLong: n toFile: f
	"Append the given 4-byte long word to the given file in my byte order. (Bytes will be swapped, if necessary, when the image is read on a different platform.) Set successFlag to false if the write fails."

	f
		nextPut: (n bitShift: -24);
		nextPut: ((n bitAnd: 16rFF0000) bitShift: -16);
		nextPut: ((n bitAnd: 16rFF00) bitShift: -8);
		nextPut: (n bitAnd: 16rFF).

	self success: true