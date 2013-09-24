object enumeration
allHeapEntitiesDo: aBlock
	<inline: true>
	self allNewSpaceEntitiesDo: aBlock.
	self allOldSpaceEntitiesDo: aBlock