enumerating
allSatisfy: aBlock
	self nodesDo: [:n| (aBlock value: n) ifFalse: [^false]].
	^true