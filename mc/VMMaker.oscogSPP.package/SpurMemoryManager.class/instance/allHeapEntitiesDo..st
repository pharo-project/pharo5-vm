object enumeration
allHeapEntitiesDo: aBlock
	"N.B. e.g. allObjects relies on the old/new order here."
	<inline: true>
	self allOldSpaceEntitiesDo: aBlock.
	self allNewSpaceEntitiesDo: aBlock