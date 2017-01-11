tests
testEmptySimulatorCanCloneSimulation
	self shouldnt:
			[(StackInterpreterSimulator newWithOptions: #(ObjectMemory Spur32BitMemoryManager))
				cloneSimulation cloneSimulation]
		raise: Error