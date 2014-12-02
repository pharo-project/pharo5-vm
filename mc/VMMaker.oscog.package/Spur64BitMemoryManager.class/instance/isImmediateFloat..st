interpreter access
isImmediateFloat: oop
	<inline: true>
	^(oop bitAnd: self tagMask) = self smallFloatTag