interpreter access
isInstanceOfClassLargePositiveInteger: oop
	"Answer if the oop is a large positive integer instance."
	^(self isNonImmediate: oop) and: [(self classIndexOf: oop) = ClassLargePositiveIntegerCompactIndex]