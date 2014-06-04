free space
lowSpaceThreshold: threshold
	lowSpaceThreshold := threshold.
	totalFreeOldSpace < threshold ifTrue:
		[self growOldSpaceByAtLeast: threshold - totalFreeOldSpace].
	self assert: totalFreeOldSpace >= lowSpaceThreshold