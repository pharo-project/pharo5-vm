simulation only
handleReadSimulationTrap: aProcessorSimulationTrap
	<doNotGenerate>
	| variableValue accessor |
	variableValue := (simulatedVariableGetters at: aProcessorSimulationTrap address) value asInteger.
	accessor := aProcessorSimulationTrap registerAccessor.
	processor
		perform: accessor
		with: variableValue signedIntToLong.
	accessor ~~ #pc: ifTrue:
		[processor pc: aProcessorSimulationTrap nextpc]