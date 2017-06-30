accessing
emptyVM
	^emptyVM ifNil:
		[emptyVM := StackInterpreterSimulator newWithOptions: #(ObjectMemory Spur32BitMemoryManager
																	  compactorClass SpurPlanningCompactor)]