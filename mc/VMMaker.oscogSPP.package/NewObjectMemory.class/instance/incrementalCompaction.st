garbage collection
incrementalCompaction
	"Move objects down to make one big free chunk. Compact the 
	last N objects (where N = number of forwarding table 
	entries) of the young object area."
	"Assume: compStart was set during the sweep phase"
	compStart = freeStart
		ifTrue: ["Note: If compStart = freeStart then either the young 
			space is already compact  or there are enough forwarding table entries to do a 
			one-pass incr. compaction."
			self initializeMemoryFirstFree: freeStart]
		ifFalse: [self incCompBody]