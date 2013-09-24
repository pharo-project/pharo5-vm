header access
setClassIndexOf: objOop to: classIndex
	self assert: (classIndex between: 0 and: self classIndexMask).
	self flag: #endianness.
	self longAt: objOop
		put: ((self longAt: objOop) bitAnd: self classIndexMask bitInvert32)
			+ classIndex