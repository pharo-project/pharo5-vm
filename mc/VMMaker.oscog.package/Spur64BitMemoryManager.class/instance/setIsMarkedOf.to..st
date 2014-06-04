header access
setIsMarkedOf: objOop to: aBoolean
	self assert: (self isFreeObject: objOop) not.
	self longAt: objOop
		put: (aBoolean
				ifTrue: [(self longAt: objOop) bitOr: 1 << self markedBitFullShift]
				ifFalse: [(self longAt: objOop) bitAnd: (1 << self markedBitFullShift) bitInvert64])