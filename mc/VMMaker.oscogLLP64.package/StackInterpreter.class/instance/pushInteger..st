internal interpreter access
pushInteger: integerValue
	self push: (objectMemory integerObjectOf: integerValue).
	^nil