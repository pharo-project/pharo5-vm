compiled methods
isExternalPrimitiveCall: aMethodObj
	"Answer if the method is an external primtiive call (prim 117)."
	<inline: true>
	^(self primitiveIndexOf: aMethodObj) = PrimNumberExternalCall