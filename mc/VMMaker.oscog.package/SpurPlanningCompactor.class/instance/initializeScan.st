compaction
initializeScan
	savedFirstFieldsSpace top: savedFirstFieldsSpace start - manager bytesPerOop.
	firstFreeObject := manager hiddenRootsObject.
	self reinitializeScan