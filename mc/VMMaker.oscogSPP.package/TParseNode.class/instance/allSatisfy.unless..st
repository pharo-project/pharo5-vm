enumerating
allSatisfy: aBlock unless: cautionaryBlock
	self
		nodesDo: [:n| (aBlock value: n) ifFalse: [^false]]
		unless: cautionaryBlock.
	^true