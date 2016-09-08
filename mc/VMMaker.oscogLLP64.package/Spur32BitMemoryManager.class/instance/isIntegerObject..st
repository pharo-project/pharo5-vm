object testing
isIntegerObject: oop
	^(oop bitAnd: self smallIntegerTag) ~= 0