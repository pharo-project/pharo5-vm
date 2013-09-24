free space
unlinkFreeChunk: chunk atIndex: index
	<inline: true>
	self assert: ((self bytesInObject: chunk) = index * self allocationUnit
				and: [index > 1 "a.k.a. (self bytesInObject: chunk) > self allocationUnit"]).
	freeLists
		at: index
		put: (self
				fetchPointer: self freeChunkNextIndex
				ofFreeChunk: chunk).
	^chunk