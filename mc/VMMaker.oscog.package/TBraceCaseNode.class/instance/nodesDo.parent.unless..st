enumerating
nodesDo: aBlock parent: parent unless: cautionaryBlock

	(cautionaryBlock value: self value: parent) ifTrue: [^self].
	caseLabels do:
		[:node| node nodesDo: aBlock parent: self unless: cautionaryBlock].
	cases do:
		[:node| node nodesDo: aBlock parent: self unless: cautionaryBlock].
	aBlock value: self value: parent