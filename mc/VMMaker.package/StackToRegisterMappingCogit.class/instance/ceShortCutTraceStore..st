simulation only
ceShortCutTraceStore: aProcessorSimulationTrap
	<doNotGenerate>
	self shortcutTrampoline: aProcessorSimulationTrap
		to: [coInterpreter
				ceTraceStoreOf: (processor registerAt: (backEnd concreteRegister: TempReg))
				into: (processor registerAt: (backEnd concreteRegister: ReceiverResultReg))]