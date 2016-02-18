garbage collection
fullCompaction
	"Move all accessible objects down to leave one big free chunk at the end of memory.
	 Assume:
		Incremental GC has just been done to maximimize forwarding table space.
		sweepPhaseForFullGC has already set compStart.
	 Need not and can not move objects below the first free chunk."
	| sz |
	self assert: compStart = (self lowestFreeAfter: self startOfMemory).
	compStart = freeStart ifTrue:
		["memory is already compact; only free chunk is at the end "
		 ^self initializeMemoryFirstFree: freeStart].
	(sz := self fwdTableSize: 8) < totalObjectCount ifTrue:
		["Try to grow OM to make a single pass full GC"
		 self growObjectMemory: totalObjectCount - sz + 10000 * 8].
	"work up through memory until all free space is at the end"
	[compStart < freeStart] whileTrue:
		["free chunk returned by incCompBody becomes start of next compaction"
		 compStart := self incCompBody]