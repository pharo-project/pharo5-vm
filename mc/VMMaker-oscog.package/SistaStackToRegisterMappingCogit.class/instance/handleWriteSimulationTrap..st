simulation only
handleWriteSimulationTrap: aProcessorSimulationTrap
	<doNotGenerate>
	| address end |
	address := aProcessorSimulationTrap address.
	(address >= methodZone freeStart
	or: [address <= methodZoneBase]) ifTrue:
		[^super handleWriteSimulationTrap: aProcessorSimulationTrap].

	(counterMethodCache isNil
	 or: [address < counterMethodCache
	 or: [counterMethodCache address + counterMethodCache blockSize < address]]) ifTrue:
		[counterMethodCache := methodZone methodFor: address].
	end := counterMethodCache address + counterMethodCache blockSize.
	self assert: (address
					between: end - (CounterBytes * counterMethodCache numCounters)
					and: end).
	objectMemory longAt: address put: (processor perform: aProcessorSimulationTrap registerAccessor).
	processor pc: aProcessorSimulationTrap nextpc