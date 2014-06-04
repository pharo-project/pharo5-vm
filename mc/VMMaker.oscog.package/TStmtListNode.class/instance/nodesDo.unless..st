enumerating
nodesDo: aBlock unless: cautionaryBlock

	(cautionaryBlock value: self) ifTrue: [^self].
	statements do: [ :s | s nodesDo: aBlock unless: cautionaryBlock ].	
	aBlock value: self