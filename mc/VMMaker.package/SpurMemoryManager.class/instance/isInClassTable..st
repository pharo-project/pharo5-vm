class table
isInClassTable: objOop
	| hash |
	hash := self rawHashBitsOf: objOop.
	hash = 0 ifTrue:
		[false].
	^(self classAtIndex: hash) = objOop