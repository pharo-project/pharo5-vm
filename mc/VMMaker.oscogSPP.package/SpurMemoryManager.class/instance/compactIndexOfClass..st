class membership
compactIndexOfClass: objOop
	self assert: (self rawHashBitsOf: objOop) ~= 0.
	^self rawHashBitsOf: objOop