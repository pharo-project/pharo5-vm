initialization
initializeBackend
	"A hook for the StackToregisterMappingCogit to override.
	 We just initialize the methodLabel here because backEnd is static."
	methodLabel machineCodeSize: 0.
	methodLabel opcode: Label.
	methodLabel operands at: 0 put: 0.
	methodLabel operands at: 1 put: 0. "label offset"
	callerSavedRegMask := backEnd callerSavedRegisterMask