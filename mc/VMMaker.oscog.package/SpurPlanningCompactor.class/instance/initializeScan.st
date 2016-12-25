compaction
initializeScan
	savedFirstFieldsSpace top: savedFirstFieldsSpace start - manager bytesPerOop.
	firstFreeObject := self scanForFirstFreeAndFirstMobileObjectFrom: (manager objectAfter: manager hiddenRootsObject).
	firstFreeObject ifNil:
		[self error: 'uncompactable heap; no unmarked objects found']