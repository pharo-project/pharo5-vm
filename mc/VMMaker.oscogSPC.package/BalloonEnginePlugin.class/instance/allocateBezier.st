allocation
allocateBezier
	| bezier |
	(self allocateObjEntry: GBBaseSize) ifFalse:[^0].
	bezier := objUsed.
	objUsed := bezier + GBBaseSize.
	self objectTypeOf: bezier put: GEPrimitiveBezier.
	self objectIndexOf: bezier put: 0.
	self objectLengthOf: bezier put: GBBaseSize.
	^bezier