interpreter access
fetchClassTagOf: oop
	| tagBits |
	^(tagBits := oop bitAnd: self tagMask) ~= 0
		ifTrue: [tagBits]
		ifFalse: [self classIndexOf: oop]