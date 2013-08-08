I/O primitives support
ioScreenSize
	"Return the screen extent packed into 32 bits."

	^ (displayForm width << 16) + displayForm height