allocation
allocateGradientFill: ramp rampWidth: rampWidth isRadial: isRadial
	| fill fillSize rampPtr |
	<var:#ramp type:'int *'>
	<var:#rampPtr type:'int *'>
	fillSize := GGBaseSize + rampWidth.
	(self allocateObjEntry: fillSize) ifFalse:[^0].
	fill := objUsed.
	objUsed := fill + fillSize.
	isRadial
		ifTrue:[self objectTypeOf: fill put: GEPrimitiveRadialGradientFill]
		ifFalse:[self objectTypeOf: fill put: GEPrimitiveLinearGradientFill].
	self objectIndexOf: fill put: 0.
	self objectLengthOf: fill put: fillSize.
	rampPtr := self gradientRampOf: fill.
	self hasColorTransform ifTrue:[
		0 to: rampWidth-1 do:[:i| rampPtr at: i put: (self transformColor: (ramp at: i))].
	] ifFalse:[
		0 to: rampWidth-1 do:[:i| rampPtr at: i put: (ramp at: i)].
	].
	self gradientRampLengthOf: fill put: rampWidth.
	^fill