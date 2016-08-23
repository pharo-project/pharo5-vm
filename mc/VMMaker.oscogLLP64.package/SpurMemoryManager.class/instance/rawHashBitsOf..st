header access
rawHashBitsOf: objOop
	<api>
	self flag: #endianness.
	^(self long32At: objOop + 4) bitAnd: self identityHashHalfWordMask