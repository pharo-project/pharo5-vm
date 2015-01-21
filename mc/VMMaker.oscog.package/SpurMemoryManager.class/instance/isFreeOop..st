object testing
isFreeOop: oop
	^(self isNonImmediate: oop) and: [self isFreeObject: oop]