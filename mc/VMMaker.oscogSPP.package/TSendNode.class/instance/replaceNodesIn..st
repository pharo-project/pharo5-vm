transformations
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		receiver := receiver replaceNodesIn: aDictionary.
		arguments := arguments collect: [ :a | a replaceNodesIn: aDictionary ].
		self]