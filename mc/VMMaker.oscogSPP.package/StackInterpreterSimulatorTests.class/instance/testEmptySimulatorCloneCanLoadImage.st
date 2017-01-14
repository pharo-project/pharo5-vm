tests
testEmptySimulatorCloneCanLoadImage
	self shouldnt:
			[(StackInterpreterSimulator newWithOptions: #(ObjectMemory Spur32BitMemoryManager))
				cloneSimulation
					openOn: self class imageNameForTests extraMemory: 0]
		raise: Error