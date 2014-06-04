transformations
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		expression := expression replaceNodesIn: aDictionary.
		cases := cases collect: [ :c | c replaceNodesIn: aDictionary ].
		self]