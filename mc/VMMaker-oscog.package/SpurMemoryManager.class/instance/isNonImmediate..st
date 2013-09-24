object testing
isNonImmediate: oop 
	^(oop bitAnd: self tagMask) = 0