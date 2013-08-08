simulation only
ceShortCutTraceStore: aProcessorSimulationTrap
	<doNotGenerate>
	self shortcutTrampoline: aProcessorSimulationTrap
		to: [coInterpreter
				ceTraceStoreOf: (processor registerAt: (methodLabel concreteRegister: ClassReg))
				into: (processor registerAt: (methodLabel concreteRegister: ReceiverResultReg))]