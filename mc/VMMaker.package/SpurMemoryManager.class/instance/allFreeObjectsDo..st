free space
allFreeObjectsDo: aBlock
	| obj |
	1 to: self numFreeLists - 1 do:
		[:i|
		obj := freeLists at: i.
		[obj ~= 0] whileTrue:
			[aBlock value: obj.
			 obj := self fetchPointer: self freeChunkNextIndex ofFreeChunk: obj]].
	self allObjectsInFreeTreeDo: aBlock