header access
setIsRememberedOf: objOop to: aBoolean
	self longAt: objOop
		put: (aBoolean
				ifTrue: [(self longAt: objOop) bitOr: 1 << self rememberedBitShift]
				ifFalse: [(self longAt: objOop) bitAnd: (1 << self rememberedBitShift) bitInvert64])