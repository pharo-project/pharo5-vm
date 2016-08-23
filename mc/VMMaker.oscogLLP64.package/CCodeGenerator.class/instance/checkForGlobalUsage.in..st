utilities
checkForGlobalUsage: vars in: aTMethod 
	vars do:
		[:var |
		(variables includes: var) ifTrue: "find the set of method names using this global var"
			[(globalVariableUsage at: var ifAbsentPut: [Set new])
				add: aTMethod selector]].
	aTMethod clearReferencesToGlobalStruct.
	(aTMethod locals select: [:l| self reservedWords includes: l]) do:
		[:l| | em |
		em := aTMethod definingClass name, '>>', aTMethod smalltalkSelector, ' has variable that is a C reserved word: ', l.
		self error: em.
		self logger cr; nextPutAll: em; cr; flush]