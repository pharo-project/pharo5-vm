simulation only
ceShortCutTraceStore: aProcessorSimulationTrap
	<doNotGenerate>
	self shortcutTrampoline: aProcessorSimulationTrap
		to: [coInterpreter
				ceTraceStoreOf: (processor registerAt: (backEnd concreteRegister: ClassReg))
				into: (processor registerAt: (backEnd concreteRegister: ReceiverResultReg))]