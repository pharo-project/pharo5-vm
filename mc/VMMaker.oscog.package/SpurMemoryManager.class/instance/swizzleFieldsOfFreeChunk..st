snapshot
swizzleFieldsOfFreeChunk: chunk
	<inline: true>
	| field |
	field := self fetchPointer: self freeChunkNextIndex ofFreeChunk: chunk.
	field ~= 0 ifTrue:
		[self storePointerNoAssert: self freeChunkNextIndex
			ofFreeChunk: chunk
			withValue: (segmentManager swizzleObj: field)].
	(self bytesInObject: chunk) >= (self numFreeLists * self allocationUnit) ifTrue:
		[self freeChunkParentIndex to: self freeChunkLargerIndex do:
			[:index|
			 field := self fetchPointer: index ofFreeChunk: chunk.
			 field ~= 0 ifTrue:
				[self storePointerNoAssert: index
					ofFreeChunk: chunk
					withValue: (segmentManager swizzleObj: field)]]]