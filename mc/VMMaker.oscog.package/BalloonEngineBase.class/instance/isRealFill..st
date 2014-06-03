testing
isRealFill: fill
	^((self objectTypeOf: fill) bitAnd: GEPrimitiveFillMask) ~= 0