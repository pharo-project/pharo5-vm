transformations
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		variable := variable replaceNodesIn: aDictionary.
		expression := expression replaceNodesIn: aDictionary.
		self]