debug support
leakCheckImageSegments
	^(checkForLeaks bitAnd: GCModeImageSegment) ~= 0