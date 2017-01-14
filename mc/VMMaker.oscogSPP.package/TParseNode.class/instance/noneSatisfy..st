enumerating
noneSatisfy: aBlock
	self nodesDo: [:n| (aBlock value: n) ifTrue: [^false]].
	^true