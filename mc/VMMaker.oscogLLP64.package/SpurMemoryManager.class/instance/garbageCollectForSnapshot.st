snapshot
garbageCollectForSnapshot
	self flushNewSpace. "There is no place to put newSpace in the snapshot file."
	self flag: 'If we wanted to shrink the rememberedSet prior to snapshot this is the place to do it.'.
	numCompactionPasses := CompactionPassesForSnapshot.
	self fullGC.
	numCompactionPasses := CompactionPassesForGC.
	segmentManager prepareForSnapshot.
	self checkFreeSpace: GCModeFull