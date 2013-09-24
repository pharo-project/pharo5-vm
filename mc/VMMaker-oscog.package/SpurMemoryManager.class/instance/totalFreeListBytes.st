free space
totalFreeListBytes
	| freeBytes bytesInObject obj |
	freeBytes := 0.
	1 to: NumFreeLists - 1 do:
		[:i| 
		bytesInObject := i * self allocationUnit.
		obj := freeLists at: i.
		[obj ~= 0] whileTrue:
			[freeBytes := freeBytes + bytesInObject.
			 self assert: bytesInObject = (self bytesInObject: obj).
			 obj := self fetchPointer: self freeChunkNextIndex ofFreeChunk: obj]].
	^freeBytes + (self bytesInFreeTree: (freeLists at: 0))