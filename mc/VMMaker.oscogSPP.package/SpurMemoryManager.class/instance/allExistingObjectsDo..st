object enumeration
allExistingObjectsDo: aBlock
	"Enumerate all objects, excluding any objects created
	 during the execution of allExistingObjectsDo:."
	<inline: true>
	self allExistingNewSpaceObjectsDo: aBlock.
	self allExistingOldSpaceObjectsDo: aBlock