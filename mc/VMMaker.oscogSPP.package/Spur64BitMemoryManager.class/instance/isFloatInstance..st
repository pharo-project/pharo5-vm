interpreter access
isFloatInstance: oop
	<inline: true>
	| tagBits |
	^(tagBits := oop bitAnd: self tagMask) ~= 0
		ifTrue: [tagBits = self smallFloatTag]
		ifFalse: [(self classIndexOf: oop) = ClassFloatCompactIndex]