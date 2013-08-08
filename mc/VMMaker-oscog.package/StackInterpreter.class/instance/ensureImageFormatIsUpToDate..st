image save/restore
ensureImageFormatIsUpToDate: swapBytes
	"Ensure the image data has been updayed to suit the current VM."
	<inline: false>
	swapBytes
		ifTrue: [self reverseBytesInImage]
		ifFalse: [self convertFloatsToPlatformOrderFrom: objectMemory firstObject to: objectMemory freeStart]