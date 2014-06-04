header access
setIsImmutableOf: objOop to: aBoolean
	self flag: #endianness.
	self longAt: objOop
		put: (aBoolean
				ifTrue: [(self longAt: objOop) bitOr: 1 << self immutableBitShift]
				ifFalse: [(self longAt: objOop) bitAnd: (1 << self immutableBitShift) bitInvert32])