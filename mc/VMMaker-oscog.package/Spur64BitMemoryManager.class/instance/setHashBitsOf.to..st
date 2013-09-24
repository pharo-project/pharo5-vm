header access
setHashBitsOf: objOop to: hash
	self assert: (hash between: 0 and: self identityHashFullWordMask).
	self longAt: objOop
		put: ((self longAt: objOop) bitClear: self identityHashFullWordMask) + hash