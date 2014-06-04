initialize-release
initialize
	super initialize.
	integerRegisterIndex := 0.
	floatRegisterIndex := 0.
	backfillFloatRegisterIndex := 0.
	integerRegisters := CArrayAccessor on: (Array new: ThreadedARMFFIPlugin numIntRegArgs).
	floatRegisters := CArrayAccessor on: (Array new: ThreadedARMFFIPlugin numFloatRegArgs)