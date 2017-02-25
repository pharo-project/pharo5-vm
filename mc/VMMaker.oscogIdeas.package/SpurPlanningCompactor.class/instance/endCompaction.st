compaction
endCompaction
	manager
		unmarkSurvivingObjectsForCompact;
		endSlidingCompaction.
	self repinRememberedSet.
	self releaseSavedFirstFieldsSpace