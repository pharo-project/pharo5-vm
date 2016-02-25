initialize-release
initialize
	super initialize.
	integerRegisterIndex := floatRegisterIndex := 0.
	integerRegisters := CArrayAccessor on: (Array new: self class pluginClass numRegArgs).
	floatRegisters := CArrayAccessor on: (Array new: self class pluginClass numFloatRegArgs)