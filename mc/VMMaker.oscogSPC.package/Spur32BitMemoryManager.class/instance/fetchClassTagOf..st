interpreter access
fetchClassTagOf: oop
	<api>
	| tagBits |
	^(tagBits := oop bitAnd: self tagMask) ~= 0
		ifTrue: [(tagBits bitAnd: 1) ~= 0 ifTrue: [1] ifFalse: [tagBits]]
		ifFalse: [self classIndexOf: oop]