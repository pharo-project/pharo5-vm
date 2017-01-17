enumerating
anySatisfy: aBlock
	self nodesDo: [:n| (aBlock value: n) ifTrue: [^true]].
	^false