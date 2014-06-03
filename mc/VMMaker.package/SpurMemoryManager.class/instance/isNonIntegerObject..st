object testing
isNonIntegerObject: oop
	^(oop bitAnd: 1) = 0