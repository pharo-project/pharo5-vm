simulation only
handleWriteSimulationTrap: aProcessorSimulationTrap 
	<doNotGenerate>
	| variableValue |
	(aProcessorSimulationTrap address between: codeBase and: methodZone zoneEnd) ifTrue:
		[self error: 'attempt to write to code space'].
	variableValue := processor perform: aProcessorSimulationTrap registerAccessor.
	(simulatedVariableSetters at: aProcessorSimulationTrap address) value: variableValue.
	processor pc: aProcessorSimulationTrap nextpc