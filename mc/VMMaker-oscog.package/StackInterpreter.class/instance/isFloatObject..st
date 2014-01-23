internal interpreter access
isFloatObject: oop
	^(objectMemory isNonIntegerObject: oop)
	   and: [ClassFloatCompactIndex ~= 0
			ifTrue: [(objectMemory compactClassIndexOf: oop) = ClassFloatCompactIndex]
			ifFalse: [(objectMemory fetchClassOfNonInt: oop) = objectMemory classFloat]]