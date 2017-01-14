image save/restore
garbageCollectForSnapshot
	self incrementalGC. "maximimize space for forwarding table"
	self fullGC.
	self clearRootsTable