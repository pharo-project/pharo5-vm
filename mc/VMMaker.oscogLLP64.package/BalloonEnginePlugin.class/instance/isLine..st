testing
isLine: line
	^((self objectTypeOf: line) bitAnd: GEPrimitiveWideMask) = GEPrimitiveLine