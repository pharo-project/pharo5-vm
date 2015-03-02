free space
validFreeTreeChunk: chunk parent: parent
	<var: 'reason' type: #'const char *'>
	<returnTypeC: #'const char *'>
	chunk = 0 ifTrue:
		[^nil].
	(self addressCouldBeOldObj: chunk) ifFalse:
		[^'not in old space'].
	(self bytesInObject: chunk) / self allocationUnit < self numFreeLists ifTrue:
		[^'too small'].
	parent ~= (self fetchPointer: self freeChunkParentIndex ofFreeChunk: chunk) ifTrue:
		[^'bad parent'].
	(self validFreeTreeChunk: (self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: chunk) parent: chunk) ifNotNil:
		[:reason| ^reason].
	(self validFreeTreeChunk: (self fetchPointer: self freeChunkLargerIndex ofFreeChunk: chunk) parent: chunk) ifNotNil:
		[:reason| ^reason].
	^nil