transformations
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		statements := statements collect: [ :s | s replaceNodesIn: aDictionary ].
		self]