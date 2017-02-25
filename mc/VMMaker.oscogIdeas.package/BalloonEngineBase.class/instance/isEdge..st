testing
isEdge: edge
	| type |
	type := self objectTypeOf: edge.
	type > GEPrimitiveEdgeMask ifTrue:[^false].
	^((self objectTypeOf: edge) bitAnd: GEPrimitiveEdgeMask) ~= 0