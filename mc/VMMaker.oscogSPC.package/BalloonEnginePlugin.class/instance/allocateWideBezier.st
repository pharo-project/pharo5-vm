allocation
allocateWideBezier
	| bezier |
	(self allocateObjEntry: GBWideSize) ifFalse:[^0].
	bezier := objUsed.
	objUsed := bezier + GBWideSize.
	self objectTypeOf: bezier put: GEPrimitiveWideBezier.
	self objectIndexOf: bezier put: 0.
	self objectLengthOf: bezier put: GBWideSize.
	^bezier