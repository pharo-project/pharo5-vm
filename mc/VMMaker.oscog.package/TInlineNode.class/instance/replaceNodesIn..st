transformations
replaceNodesIn: map
	^map at: self ifAbsent: [
		method replaceNodesIn: map.
		self]