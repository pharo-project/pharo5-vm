enumerating
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	expression nodesDo: aBlock unless: cautionaryBlock.
	aBlock value: self.