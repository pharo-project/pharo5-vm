compaction - analysis
abstractCompaction
	"This method answers a rough estimate of compactibility."
	<doNotGenerate>
	| lowestFree freeChunks used movable |
	lowestFree := SmallInteger maxVal.
	freeChunks := Set new.
	used := Set new.
	movable := Set new.
	self allObjectsInFreeTreeDo:
		[:f|
		(self addressAfter: f) < endOfMemory ifTrue:
			[freeChunks add: f.
			 f < lowestFree ifTrue: [lowestFree := f]]].
	self allOldSpaceObjectsFrom: lowestFree do:
		[:o| | size delta best |
		size := self bytesInObject: o.
		delta := SmallInteger maxVal.
		freeChunks do: [:f| | fs |
			((fs := self bytesInObject: f) >= size) ifTrue:
				[delta > (fs - size) ifTrue:
					[delta := fs - size. best := f]]].
		 best ifNotNil:
			[movable add: o.
			 used add: (freeChunks remove: best)]].
	^{ totalFreeOldSpace. movable inject: 0 into: [:s :o| s + (self bytesInObject: o)]. used inject: 0 into: [:s :o| s + (self bytesInObject: o)] }