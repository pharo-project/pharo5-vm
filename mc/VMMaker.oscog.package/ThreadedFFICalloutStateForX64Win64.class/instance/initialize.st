initialize-release
initialize
	super initialize.
	integerRegisterIndex := floatRegisterIndex := floatRegisterSignature := 0.
	integerRegisters := CArrayAccessor on: (Array new: ThreadedX64Win64FFIPlugin numRegArgs).
	floatRegisters := CArrayAccessor on: (Array new: ThreadedX64Win64FFIPlugin numFloatRegArgs)