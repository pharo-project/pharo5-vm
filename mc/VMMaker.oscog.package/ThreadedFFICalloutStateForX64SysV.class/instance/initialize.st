initialize-release
initialize
	super initialize.
	integerRegisterIndex := floatRegisterIndex := 0.
	integerRegisters := CArrayAccessor on: (Array new: ThreadedX64SysVFFIPlugin numRegArgs).
	floatRegisters := CArrayAccessor on: (Array new: ThreadedX64SysVFFIPlugin numFloatRegArgs)