gc - global
checkNoForwardersBelowFirstFreeChunk
	self allOldSpaceEntitiesDo:
		[:o|
		(self oop: o isGreaterThanOrEqualTo: firstFreeChunk) ifTrue:
			[^true].
		(self asserta: (self isForwarded: o) not) ifFalse:
			[^false]].
	^true