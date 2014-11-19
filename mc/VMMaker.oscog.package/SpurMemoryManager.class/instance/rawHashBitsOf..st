header access
rawHashBitsOf: objOop
	self flag: #endianness.
	^(self long32At: objOop + 4) bitAnd: self identityHashHalfWordMask