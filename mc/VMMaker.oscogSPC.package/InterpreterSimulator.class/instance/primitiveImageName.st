file primitives
primitiveImageName
	"Note: For now, this only implements getting, not setting, the image file name."
	| result imageNameSize |
	self pop: 1.
	imageNameSize := imageName size.
	result := self instantiateClass: (self splObj: ClassByteString)
				   indexableSize: imageNameSize.
	1 to: imageNameSize do:
		[:i | self storeByte: i-1 ofObject: result
			withValue: (imageName at: i) asciiValue].
	self push: result.