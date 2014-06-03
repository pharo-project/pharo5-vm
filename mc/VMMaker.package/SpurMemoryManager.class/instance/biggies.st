compaction - analysis
biggies
	"This method answers a sorted collection of the objects >= 1,000,000 bytes long,
	 above the lowest large free chunk, sandwiched between nilObj and the end of memory."
	<doNotGenerate>
	| lowestFree biggies |
	lowestFree := SmallInteger maxVal.
	self allObjectsInFreeTreeDo:
		[:f| (self addressAfter: f) < endOfMemory ifTrue: [f < lowestFree ifTrue: [lowestFree := f]]].
	biggies := SortedCollection new.
	self allOldSpaceObjectsFrom: lowestFree do:
		[:f|
		(self bytesInObject: f) >= 1000000 ifTrue:
			[biggies add: f]].
	^{{nilObj hex. #nil}}, (biggies collect: [:f| {f hex. self bytesInObject: f}]), {{endOfMemory hex. #endOfMemory}}