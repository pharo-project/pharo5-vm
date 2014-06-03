header access
setIsPinnedOf: objOop to: aBoolean
	self longAt: objOop
		put: (aBoolean
				ifTrue: [(self longAt: objOop) bitOr: 1 << self pinnedBitShift]
				ifFalse: [(self longAt: objOop) bitAnd: (1 << self pinnedBitShift) bitInvert64])