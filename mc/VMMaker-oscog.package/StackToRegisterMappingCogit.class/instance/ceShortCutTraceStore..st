simulation only
ceShortCutTraceStore: aProcessorSimulationTrap
	<doNotGenerate>
	self shortcutTrampoline: aProcessorSimulationTrap
		to: [coInterpreter
				ceTraceStoreOf: (processor registerAt: (methodLabel concreteRegister: TempReg))
				into: (processor registerAt: (methodLabel concreteRegister: ReceiverResultReg))]