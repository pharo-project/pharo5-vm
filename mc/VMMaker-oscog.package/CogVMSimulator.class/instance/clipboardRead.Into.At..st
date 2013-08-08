I/O primitives
clipboardRead: sz Into: actualAddress At: zeroBaseIndex
	| str |
	str := Clipboard clipboardText.
	1 to: sz do:
		[:i | self byteAt: actualAddress + zeroBaseIndex + i - 1 put: (str at: i) asciiValue]