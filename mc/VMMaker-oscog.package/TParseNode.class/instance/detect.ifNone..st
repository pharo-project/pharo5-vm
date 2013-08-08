enumerating
detect: aBlock ifNone: defaultBlock
	self nodesDo: [:n| (aBlock value: n) ifTrue: [^n]].
	^defaultBlock value