snapshot
garbageCollectForSnapshot
	self flushNewSpace. "There is no place to put newSpace in the snapshot file."
	self fullGC.
	segmentManager prepareForSnapshot.
	self checkFreeSpace