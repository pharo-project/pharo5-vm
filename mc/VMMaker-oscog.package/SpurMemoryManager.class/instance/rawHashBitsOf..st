header access
rawHashBitsOf: objOop
	self flag: #endianness.
	^(self longAt: objOop + 4) bitAnd: self identityHashHalfWordMask