initialize-release
initialize
	super initialize.
	regIndex := 0.
	integerRegisters := CArrayAccessor on: (Array new: ThreadedARMFFIPlugin numRegArgs)