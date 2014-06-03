image save/restore
ensureImageFormatIsUpToDate: swapBytes
	"Ensure the image data has been updated to suit the current VM."
	<inline: false>
	swapBytes
		ifTrue: [self reverseBytesInImage]
		ifFalse: [self convertFloatsToPlatformOrder]