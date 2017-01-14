header access
isImmutable: objOop
	^((self longAt: objOop) >> self immutableBitShift bitAnd: 1) ~= 0