interpreter access
fetchClassTagOf: oop
	<api>
	| tagBits |
	^(tagBits := oop bitAnd: self tagMask) ~= 0
		ifTrue: [tagBits]
		ifFalse: [self classIndexOf: oop]