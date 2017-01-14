simulation only
handleSimulationTrap: aProcessorSimulationTrap
	<doNotGenerate>
	aProcessorSimulationTrap type caseOf:
		{ [#read] -> [self handleReadSimulationTrap: aProcessorSimulationTrap].
		  [#write] -> [self handleWriteSimulationTrap: aProcessorSimulationTrap].
		  [#call] -> [self handleCallOrJumpSimulationTrap: aProcessorSimulationTrap].
		  [#jump] -> [self handleCallOrJumpSimulationTrap: aProcessorSimulationTrap] }