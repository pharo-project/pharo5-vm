enumerating
anySatisfy: aBlock unless: cautionaryBlock
	self
		nodesDo: [:n| (aBlock value: n) ifTrue: [^true]]
		unless: cautionaryBlock.
	^false