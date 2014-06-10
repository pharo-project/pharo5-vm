enumerating
noneSatisfy: aBlock unless: cautionaryBlock
	self
		nodesDo: [:n| (aBlock value: n) ifTrue: [^false]]
		unless: cautionaryBlock.
	^true