free space
unlinkFreeChunk: chunk atIndex: index
	"Unlink and answer a small chunk from one of the fixed size freeLists"
	<inline: true>
	self assert: ((self bytesInObject: chunk) = (index * self allocationUnit)
				and: [index > 1 "a.k.a. (self bytesInObject: chunk) > self allocationUnit"
				and: [(self startOfObject: chunk) = chunk]]).
	freeLists
		at: index
		put: (self
				fetchPointer: self freeChunkNextIndex
				ofFreeChunk: chunk).
	^chunk