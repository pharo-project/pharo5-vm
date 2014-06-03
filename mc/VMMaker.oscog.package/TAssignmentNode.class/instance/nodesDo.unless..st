enumerating
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	variable nodesDo: aBlock unless: cautionaryBlock.
	expression nodesDo: aBlock unless: cautionaryBlock.
	aBlock value: self.