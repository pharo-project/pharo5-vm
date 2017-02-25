allocation
allocateLine
	| line |
	(self allocateObjEntry: GLBaseSize) ifFalse:[^0].
	line := objUsed.
	objUsed := line + GLBaseSize.
	self objectTypeOf: line put: GEPrimitiveLine.
	self objectIndexOf: line put: 0.
	self objectLengthOf: line put: GLBaseSize.
	^line