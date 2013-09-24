object testing
isCharacterObject: oop
	^(oop bitAnd: self tagMask) = self characterTag