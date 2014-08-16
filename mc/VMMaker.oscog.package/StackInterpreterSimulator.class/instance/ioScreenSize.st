I/O primitives support
ioScreenSize
	"Return the screen extent packed into 32 bits."

	^displayForm
		ifNotNil: [(displayForm width << 16) + displayForm height]
		ifNil: [savedWindowSize ifNil: 640 << 16 + 480]