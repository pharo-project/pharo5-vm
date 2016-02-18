enumerating
nodesDo: aBlock parent: parent unless: cautionaryBlock

	(cautionaryBlock value: self value: parent) ifTrue: [^self].
	statements do: [ :s | s nodesDo: aBlock parent: self unless: cautionaryBlock].
	aBlock value: self value: parent