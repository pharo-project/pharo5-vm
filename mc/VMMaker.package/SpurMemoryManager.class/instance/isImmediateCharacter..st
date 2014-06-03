object testing
isImmediateCharacter: oop
	^(oop bitAnd: self tagMask) = 2