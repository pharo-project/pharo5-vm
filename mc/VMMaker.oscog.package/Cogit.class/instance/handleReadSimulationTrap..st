simulation only
handleReadSimulationTrap: aProcessorSimulationTrap
	<doNotGenerate>
	| variableValue |
	variableValue := (simulatedVariableGetters at: aProcessorSimulationTrap address) value asInteger.
	processor
		perform: aProcessorSimulationTrap registerAccessor
		with: variableValue signedIntToLong.
	processor pc: aProcessorSimulationTrap nextpc