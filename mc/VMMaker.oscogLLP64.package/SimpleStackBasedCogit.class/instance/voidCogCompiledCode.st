jit - api
voidCogCompiledCode
	<api>
	methodZone clearCogCompiledCode.
	0 to: MaxNumArgs do:
		[:i|
		externalPrimJumpOffsets at: i put: nil.
		externalPrimCallOffsets at: i put: nil.
		externalSetPrimOffsets at: i put: nil]