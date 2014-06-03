testing
areEdgeFillsValid: edge

	^((self objectHeaderOf: edge) bitAnd: GEEdgeFillsInvalid) = 0