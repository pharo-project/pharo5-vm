compiled methods
isCogMethodReference: methodHeader
	<api>
	self assert: ((objectMemory isIntegerObject: methodHeader)
				or: [methodHeader asUnsignedInteger < objectMemory startOfMemory
					and: [methodHeader asUnsignedInteger >= cogit minCogMethodAddress]]).
	^objectMemory isNonIntegerObject: methodHeader