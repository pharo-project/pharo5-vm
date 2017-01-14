free space
lowSpaceThreshold: threshold
	lowSpaceThreshold := threshold.
	"N.B. The threshold > 0 guard eliminates a warning when
		self lowSpaceThreshold: 0
	 is inlined into setSignalLowSpaceFlagAndSaveProcess"
	(threshold > 0
	 and: [totalFreeOldSpace < threshold]) ifTrue:
		[self growOldSpaceByAtLeast: threshold - totalFreeOldSpace].
	self assert: totalFreeOldSpace >= lowSpaceThreshold