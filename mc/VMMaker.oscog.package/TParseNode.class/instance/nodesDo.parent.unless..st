enumerating
nodesDo: aBlock parent: parent unless: cautionaryBlock
	"Evaluate aBlock for all nodes in  the tree except those for which cautionaryBlock
	 answers true or are children of those for which cautionaryBlock answers true."
	(cautionaryBlock value: self value: parent) ifFalse:
		[aBlock value: self value: parent]