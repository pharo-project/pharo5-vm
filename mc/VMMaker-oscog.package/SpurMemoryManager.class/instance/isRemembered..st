header access
isRemembered: objOop
	^((self longAt: objOop) >> self rememberedBitShift bitAnd: 1) ~= 0