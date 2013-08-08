image save/restore
putShort: n toFile: f
	"Append the given 2-byte half-word to the given file in my byte order. (Bytes will be swapped, if necessary, when the image is read on a different platform.) Set successFlag to false if the write fails."

	[f nextNumber: 2 put: n]
		on: Error
		do: [:ex| coInterpreter success: false]