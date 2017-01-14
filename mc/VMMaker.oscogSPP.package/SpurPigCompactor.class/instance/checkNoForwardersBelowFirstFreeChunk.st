compaction - asserts
checkNoForwardersBelowFirstFreeChunk
	manager allOldSpaceEntitiesDo:
		[:o|
		(self oop: o isGreaterThanOrEqualTo: firstFreeChunk) ifTrue:
			[^true].
		(self asserta: (manager isForwarded: o) not) ifFalse:
			[^false]].
	^true