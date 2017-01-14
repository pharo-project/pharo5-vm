snapshot
setEndOfMemory: newEndOfMemory
	"Set by the segment manager after swizzling the image,
	 and by the SpurBootstrap on writing out the transformed image."
	endOfMemory := newEndOfMemory.
	freeOldSpaceStart > newEndOfMemory ifTrue:
		[freeOldSpaceStart := newEndOfMemory]