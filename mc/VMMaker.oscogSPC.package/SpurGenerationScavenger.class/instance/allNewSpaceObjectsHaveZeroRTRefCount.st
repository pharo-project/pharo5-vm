remembered set
allNewSpaceObjectsHaveZeroRTRefCount
	manager allNewSpaceObjectsDo:
		[:obj|
		(manager rtRefCountOf: obj) > 0 ifTrue:
			[^false]].
	^true