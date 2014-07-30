class table
isInClassTable: objOop
	| hash |
	hash := self rawHashBitsOf: objOop.
	^hash ~= 0
	 and: [(self classAtIndex: hash) = objOop]