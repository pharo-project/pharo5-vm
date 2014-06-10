page access
memIndexFor: byteAddress
	^(self oopForPointer: byteAddress) // BytesPerWord + indexOffset