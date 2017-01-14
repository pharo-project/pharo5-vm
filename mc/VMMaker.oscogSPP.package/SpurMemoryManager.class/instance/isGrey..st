header access
isGrey: objOop
	^((self longAt: objOop) >> self greyBitShift bitAnd: 1) ~= 0