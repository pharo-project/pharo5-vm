method cacheing
maybeShiftClassTagRegisterForMethodCacheProbe: classTagReg
	"If required, generate a shift of the register containing the class tag in a method cache probe.
	 By default this is a no-op.  Subclasses redefine as required."

	^0