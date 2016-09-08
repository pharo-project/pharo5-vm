enumerating
nodesWithParentsDo: aBlock unless: cautionaryBlock
	"Evaluate aBlock for all nodes in the tree and their parent except those for which
	 cautionaryBlock answers true or are children of those for which cautionaryBlock
	 answers true. Cautionary block is invoked with node and parent.  parent may be nil."
	self nodesDo: aBlock parent: nil unless: cautionaryBlock