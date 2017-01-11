initialize-release
initialize
	emptyVM := StackInterpreterSimulator newWithOptions: #(ObjectMemory Spur32BitMemoryManager
																 compactorClass SpurPlanningCompactor)