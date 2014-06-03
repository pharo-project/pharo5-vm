enumerating
replaceNodesIn: aDictionary

	^aDictionary at: self ifAbsent: [
		caseLabels := caseLabels collect: [:node| node replaceNodesIn: aDictionary].
		cases := cases collect: [:node| node replaceNodesIn: aDictionary].
		self]