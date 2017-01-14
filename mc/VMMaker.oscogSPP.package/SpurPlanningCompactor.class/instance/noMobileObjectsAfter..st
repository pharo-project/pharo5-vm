private
noMobileObjectsAfter: mobileObj
	self assert: ((manager isMarked: mobileObj) and: [(manager isPinned: mobileObj) not]).
	manager allOldSpaceEntitiesFrom: mobileObj do:
		[:o|
		 ((manager isMarked: o) and: [(manager isPinned: o) not]) ifTrue:
			[^false]].
	^true