initialize-release
initialize
	super initialize.
	registerIndex := 0.
	integerRegisters := CArrayAccessor on: (Array new: self class pluginClass numRegArgs).
	floatRegisters := CArrayAccessor on: (Array new: self class pluginClass numFloatRegArgs)