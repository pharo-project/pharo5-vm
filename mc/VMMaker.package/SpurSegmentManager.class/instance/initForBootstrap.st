spur bootstrap
initForBootstrap
	numSegInfos = 0 ifTrue:
		[self allocateOrExtendSegmentInfos]