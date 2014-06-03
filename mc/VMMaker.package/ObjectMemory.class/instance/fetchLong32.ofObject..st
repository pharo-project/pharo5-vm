interpreter access
fetchLong32: fieldIndex ofObject: oop
	" index by 32-bit units, and return a 32-bit value. Intended to replace fetchWord:ofObject:"

	^ self long32At: oop + BaseHeaderSize + (fieldIndex << 2)