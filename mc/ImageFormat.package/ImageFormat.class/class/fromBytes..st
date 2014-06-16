instance creation
fromBytes: bytes
	^ self fromStream: (ReadStream on: bytes)
