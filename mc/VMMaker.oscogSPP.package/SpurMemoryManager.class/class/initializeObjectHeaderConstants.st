class initialization
initializeObjectHeaderConstants

	BytesPerWord ifNil: [BytesPerWord := 4].  "May get called on fileIn, so supply default"
	BaseHeaderSize := 8. "This is still needed for VM generation."

	"These are used in image segments"
	self ~~ SpurMemoryManager ifTrue:
		[TopHashBit := 1 << (self basicNew identityHashFieldWidth - 1).
		 TopOopBit := 1 << (self basicNew bytesPerOop * 8 - 1)]