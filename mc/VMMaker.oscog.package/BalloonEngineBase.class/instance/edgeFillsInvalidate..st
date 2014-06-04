accessing edges
edgeFillsInvalidate: edge

	^self objectTypeOf: edge put: 
		((self objectTypeOf: edge) bitOr: GEEdgeFillsInvalid)