snapshot
memoryBaseForImageRead
	"Answer the address to read the image into.  Override so that when bootstrapping,
	 the segmentManager's segments are undisturbed in adjustSegmentSwizzlesBy:"
	^bootstrapping
		ifTrue: [0] 
		ifFalse: [super memoryBaseForImageRead]