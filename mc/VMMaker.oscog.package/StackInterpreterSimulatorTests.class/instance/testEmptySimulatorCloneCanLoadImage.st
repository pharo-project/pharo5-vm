tests
testEmptySimulatorCloneCanLoadImage
	self shouldnt:
			[(StackInterpreterSimulator newWithOptions: #(ObjectMemory Spur32BitMemoryManager))
				cloneSimulation
					openOn: SpurImageTestResource imageNameForTests extraMemory: 0]
		raise: Error