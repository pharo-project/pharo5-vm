compaction
reinitializeScan
	firstFreeObject := self scanForFirstFreeAndFirstMobileObjectFrom: firstFreeObject.
	firstFreeObject ifNil:
		[self error: 'uncompactable heap; no unmarked objects found']