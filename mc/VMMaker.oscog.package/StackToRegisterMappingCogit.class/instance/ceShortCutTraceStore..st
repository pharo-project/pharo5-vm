simulation only
ceShortCutTraceStore: aProcessorSimulationTrap
	<doNotGenerate>
	self shortcutTrampoline: aProcessorSimulationTrap
		to: [coInterpreter
				ceTraceStoreOf: (processor registerAt: TempReg)
				into: (processor registerAt: ReceiverResultReg)]