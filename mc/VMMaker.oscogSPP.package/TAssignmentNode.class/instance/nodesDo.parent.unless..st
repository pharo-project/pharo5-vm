enumerating
nodesDo: aBlock parent: parent unless: cautionaryBlock

	(cautionaryBlock value: self value: parent) ifTrue: [^self].
	variable nodesDo: aBlock parent: self unless: cautionaryBlock.
	expression nodesDo: aBlock parent: self unless: cautionaryBlock.
	aBlock value: self value: parent