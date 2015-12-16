simulation only
handleWriteSimulationTrap: aProcessorSimulationTrap 
	<doNotGenerate>
	| variableValue |
	(self addressIsInCodeZone: aProcessorSimulationTrap address) ifTrue:
		[self error: 'attempt to write to code space'].
	variableValue := processor perform: aProcessorSimulationTrap registerAccessor.
	(simulatedVariableSetters at: aProcessorSimulationTrap address) value: variableValue.
	processor pc: aProcessorSimulationTrap nextpc