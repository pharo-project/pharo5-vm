object enumeration
allOldSpaceObjectsDo: aBlock
	<inline: true>
	self allOldSpaceObjectsFrom: self firstObject do: aBlock