interpreter shell
unknownBytecode
	"This should never get called; it means that an unimplemented bytecode appears in a CompiledMethod."

	self error: 'Unknown bytecode'.