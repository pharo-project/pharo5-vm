enumerating
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	expression nodesDo: aBlock unless: cautionaryBlock.
	cases do:
		[:pair|
		pair first do: [:node| node nodesDo: aBlock unless: cautionaryBlock].
		pair last nodesDo: aBlock unless: cautionaryBlock].
	otherwiseOrNil ifNotNil:
		[otherwiseOrNil nodesDo: aBlock unless: cautionaryBlock]