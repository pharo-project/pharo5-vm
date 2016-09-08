interpreter access
isInstanceOfClassLargeNegativeInteger: oop
	"Answer if the oop is a large negative integer instance."
	^(self isNonImmediate: oop) and: [(self classIndexOf: oop) = ClassLargeNegativeIntegerCompactIndex]