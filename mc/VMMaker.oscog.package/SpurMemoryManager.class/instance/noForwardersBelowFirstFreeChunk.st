gc - global
noForwardersBelowFirstFreeChunk
	self allOldSpaceEntitiesDo:
		[:o|
		 (self oop: o isGreaterThanOrEqualTo: firstFreeChunk) ifTrue:
			[^true].
		 (self isForwarded: o) ifTrue:
			[^false]].
	^true