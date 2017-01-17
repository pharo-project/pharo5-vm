object access
fetchClassOf: oop
	| tagBits |
	^(tagBits := oop bitAnd: self tagMask) ~= 0
		ifTrue: [self fetchPointer: tagBits ofObject: classTableFirstPage]
		ifFalse: [self fetchClassOfNonImm: oop]