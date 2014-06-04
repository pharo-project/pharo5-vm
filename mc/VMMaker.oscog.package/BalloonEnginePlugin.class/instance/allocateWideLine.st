allocation
allocateWideLine
	| line |
	(self allocateObjEntry: GLWideSize) ifFalse:[^0].
	line := objUsed.
	objUsed := line + GLWideSize.
	self objectTypeOf: line put: GEPrimitiveWideLine.
	self objectIndexOf: line put: 0.
	self objectLengthOf: line put: GLWideSize.
	^line