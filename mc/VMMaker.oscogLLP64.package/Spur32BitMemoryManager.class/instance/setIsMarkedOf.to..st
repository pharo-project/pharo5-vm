header access
setIsMarkedOf: objOop to: aBoolean
	self assert: (self isFreeObject: objOop) not.
	self flag: #endianness.
	self longAt: objOop + 4
		put: (aBoolean
				ifTrue: [(self longAt: objOop + 4) bitOr: 1 << self markedBitHalfShift]
				ifFalse: [(self longAt: objOop + 4) bitAnd: (1 << self markedBitHalfShift) bitInvert32])