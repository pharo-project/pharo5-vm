object testing
isImmediate: oop 
	^(oop bitAnd: self tagMask) ~= 0