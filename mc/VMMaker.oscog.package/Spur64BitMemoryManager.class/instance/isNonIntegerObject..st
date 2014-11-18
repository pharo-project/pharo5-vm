object testing
isNonIntegerObject: oop
	^(oop bitAnd: self tagMask) ~= 1