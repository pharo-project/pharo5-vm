object testing
isIntegerObject: oop
	^(oop bitAnd: 1) ~= 0