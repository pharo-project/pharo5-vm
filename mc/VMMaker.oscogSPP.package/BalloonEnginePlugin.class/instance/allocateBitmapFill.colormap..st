allocation
allocateBitmapFill: cmSize colormap: cmBits
	| fill fillSize cm |
	<var:#cm type:'int *'>
	<var:#cmBits type:'int *'>
	fillSize := GBMBaseSize + cmSize.
	(self allocateObjEntry: fillSize) ifFalse:[^0].
	fill := objUsed.
	objUsed := fill + fillSize.
	self objectTypeOf: fill put: GEPrimitiveClippedBitmapFill.
	self objectIndexOf: fill put: 0.
	self objectLengthOf: fill put: fillSize.
	cm := self colormapOf: fill.
	self hasColorTransform ifTrue:[
		0 to: cmSize-1 do:[:i| cm at: i put: (self transformColor: (cmBits at: i))].
	] ifFalse:[
		0 to: cmSize-1 do:[:i| cm at: i put: (cmBits at: i)].
	].
	self bitmapCmSizeOf: fill put: cmSize.
	^fill