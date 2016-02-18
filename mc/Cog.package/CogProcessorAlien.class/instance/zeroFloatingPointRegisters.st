accessing-abstract
zeroFloatingPointRegisters
	self floatingPointRegisterStateSetters do:
		[:setter| self perform: setter with: 0]