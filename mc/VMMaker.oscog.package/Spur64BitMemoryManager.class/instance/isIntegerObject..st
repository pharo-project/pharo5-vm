object testing
isIntegerObject: oop
	^(oop bitAnd: self tagMask) = 1