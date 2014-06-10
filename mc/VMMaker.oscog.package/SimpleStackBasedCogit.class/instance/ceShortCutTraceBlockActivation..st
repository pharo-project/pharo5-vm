simulation only
ceShortCutTraceBlockActivation: aProcessorSimulationTrap
	self shortcutTrampoline: aProcessorSimulationTrap
		to: [coInterpreter ceTraceBlockActivation]