object testing
isNonImmediate: oop
	<api>
	^(oop bitAnd: self tagMask) = 0