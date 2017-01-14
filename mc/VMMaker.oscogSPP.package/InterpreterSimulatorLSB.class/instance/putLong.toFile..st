image save/restore
putLong: n toFile: f
	"Append the given 4-byte long word to the given file in my byte order. (Bytes will be swapped, if necessary, when the image is read on a different platform.) Set successFlag to false if the write fails."

	| remainingValue |

	remainingValue := n.
	4 timesRepeat: [
		f nextPut: (remainingValue bitAnd: 16rFF).
		remainingValue := remainingValue bitShift: -8].

	self success: true