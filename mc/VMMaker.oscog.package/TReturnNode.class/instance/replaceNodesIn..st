transformations
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		expression := expression replaceNodesIn: aDictionary.
		self]