type inference
isSimpleType: aType
	"For the purposes of the read-before-written initializer, answer if
	 aType is simple, e.g. not a structure, and array or an opaque type."
	^(self isPointerCType: aType)
	  or: [self isIntegralCType: aType]