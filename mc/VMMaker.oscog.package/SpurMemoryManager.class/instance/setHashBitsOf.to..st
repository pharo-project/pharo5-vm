header access
setHashBitsOf: objOop to: hash
	self flag: #endianness.
	self assert: (hash between: 0 and: self identityHashHalfWordMask).
	self long32At: objOop + 4
		put: ((self long32At: objOop + 4) bitClear: self identityHashHalfWordMask) + hash