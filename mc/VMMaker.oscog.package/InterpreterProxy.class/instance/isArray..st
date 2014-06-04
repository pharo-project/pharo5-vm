testing
isArray: oop
	^(self isNonImmediate: oop) and: [oop class instSpec = 2]