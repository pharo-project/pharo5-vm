header access
newHashBitsOf: objOop
	| hash |
	hash := self newObjectHash bitAnd: self identityHashHalfWordMask.
	self setHashBitsOf: objOop to: hash.
	^hash