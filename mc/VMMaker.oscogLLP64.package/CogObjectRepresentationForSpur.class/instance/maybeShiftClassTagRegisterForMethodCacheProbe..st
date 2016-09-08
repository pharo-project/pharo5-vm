method cacheing
maybeShiftClassTagRegisterForMethodCacheProbe: classTagReg
	"Generate a shift of the register containing the class tag in a method cache probe.
	 c.f. SpurMemoryManager>>methodCacheHashOf:with:"

	cogit LogicalShiftLeftCq: 2 R: classTagReg.
	^0