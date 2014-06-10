compaction - analysis
largeFreeChunkDistribution
	"This method answers a sorted collection of the free chunks >= 1,000,000 bytes long,
	 sandwiched between nilObj and the end of memory (ignoring the large chunk often found at the end of the heap)."
	<doNotGenerate>
	| freeChunks |
	freeChunks := SortedCollection new.
	self allObjectsInFreeTreeDo:
		[:f|
		((self addressAfter: f) < endOfMemory
		 and: [(self bytesInObject: f) >= 1000000]) ifTrue:
			[freeChunks add: f]].
	^{{nilObj hex. #nil}}, (freeChunks collect: [:f| {f hex. self bytesInObject: f}]), {{endOfMemory hex. #endOfMemory}}