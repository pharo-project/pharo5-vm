header access
setHashBitsOf: objOop to: hash
	self flag: #endianness.
	self assert: (hash between: 0 and: self identityHashHalfWordMask).
	self longAt: objOop + 4
		put: ((self longAt: objOop + 4) bitClear: self identityHashHalfWordMask) + hash