internal interpreter access
isFloatObject: oop
	^(objectMemory isNonImmediate: oop)
	   and: [ClassFloatCompactIndex = (objectMemory compactClassIndexOf: oop)]