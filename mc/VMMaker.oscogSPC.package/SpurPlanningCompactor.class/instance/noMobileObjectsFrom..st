private
noMobileObjectsFrom: mobileObj
	<inline: false>
	manager allOldSpaceEntitiesFrom: mobileObj do:
		[:o|
		 ((manager isMarked: o) and: [(manager isPinned: o) not]) ifTrue:
			[^false]].
	^true