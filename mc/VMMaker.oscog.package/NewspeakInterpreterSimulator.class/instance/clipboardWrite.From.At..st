I/O primitives
clipboardWrite: sz From: actualDataAddress At: ignored

	Clipboard clipboardText: (self stringOf: actualDataAddress - self baseHeaderSize)