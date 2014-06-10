object enumeration
allOldSpaceEntitiesDo: aBlock
	<inline: true>
	self allOldSpaceEntitiesFrom: self firstObject do: aBlock