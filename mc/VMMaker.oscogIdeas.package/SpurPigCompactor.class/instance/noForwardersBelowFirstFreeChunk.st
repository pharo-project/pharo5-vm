compaction - asserts
noForwardersBelowFirstFreeChunk
	manager allOldSpaceEntitiesDo:
		[:o|
		 (self oop: o isGreaterThanOrEqualTo: firstFreeChunk) ifTrue:
			[^true].
		 (manager isForwarded: o) ifTrue:
			[^false]].
	^true