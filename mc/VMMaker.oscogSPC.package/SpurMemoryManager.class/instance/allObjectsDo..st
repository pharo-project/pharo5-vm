object enumeration
allObjectsDo: aBlock
	<inline: true>
	self allNewSpaceObjectsDo: aBlock.
	self allOldSpaceObjectsDo: aBlock