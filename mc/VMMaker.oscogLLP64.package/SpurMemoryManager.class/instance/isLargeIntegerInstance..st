interpreter access
isLargeIntegerInstance: oop
	"Answer if the oop is a large positive or negative integer instance."
	^(self isNonImmediate: oop) and: [((self classIndexOf: oop) - ClassLargeNegativeIntegerCompactIndex) asUnsignedInteger <= 1]