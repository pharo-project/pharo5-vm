header access
setIsGreyOf: objOop to: aBoolean
	self flag: #endianness.
	self longAt: objOop
		put: (aBoolean
				ifTrue: [(self longAt: objOop) bitOr: 1 << self greyBitShift]
				ifFalse: [(self longAt: objOop) bitAnd: (1 << self greyBitShift) bitInvert32])