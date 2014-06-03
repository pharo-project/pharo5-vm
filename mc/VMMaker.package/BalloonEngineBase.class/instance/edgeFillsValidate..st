accessing edges
edgeFillsValidate: edge

	^self objectTypeOf: edge put: 
		((self objectTypeOf: edge) bitAnd: GEEdgeFillsInvalid bitInvert32)