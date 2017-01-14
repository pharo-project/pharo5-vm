enumerating
nodesDo: aBlock parent: parent unless: cautionaryBlock

	(cautionaryBlock value: self value: parent) ifTrue: [^self].
	receiver nodesDo: aBlock parent: self unless: cautionaryBlock.
	arguments do: [ :arg | arg nodesDo: aBlock parent: self unless: cautionaryBlock].
	aBlock value: self value: parent