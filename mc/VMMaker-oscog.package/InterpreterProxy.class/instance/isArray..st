testing
isArray: oop
	^(self isIntegerObject: oop) not and:[(oop class format bitAnd: 15) = 2]
