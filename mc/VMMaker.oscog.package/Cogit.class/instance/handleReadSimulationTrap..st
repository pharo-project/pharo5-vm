simulation only
handleReadSimulationTrap: aProcessorSimulationTrap
	"Try to read the value of a variable given its fake address in simulatedVariableGetters.
	 simulatedVariableGetters maps to an evaluable that yields the variable's actual value.
	 To support the x64, also gracefully accept an address which is in simulatedTrampolines,
	 in which case no mapping is necessary."
	<doNotGenerate>
	| address variableValue accessor |
	address := aProcessorSimulationTrap address.
	variableValue := (simulatedVariableGetters
						at: address
						ifAbsent:
							[(simulatedTrampolines includesKey: address)
								ifTrue: [address]
								ifFalse: [simulatedVariableGetters errorKeyNotFound]]) value asInteger.
	accessor := aProcessorSimulationTrap registerAccessor.
	processor
		perform: accessor
		with: (variableValue == address
				ifTrue: [address]
				ifFalse: [processor convertIntegerToInternal: variableValue]).
	accessor ~~ #pc: ifTrue:
		[processor pc: aProcessorSimulationTrap nextpc]