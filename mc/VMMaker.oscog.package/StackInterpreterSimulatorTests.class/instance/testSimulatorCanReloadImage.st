tests
testSimulatorCanReloadImage
	self shouldnt:
			[(StackInterpreterSimulator newWithOptions: #(ObjectMemory Spur32BitMemoryManager))
				openOn: SpurImageTestResource imageNameForTests extraMemory: 0;
				openOn: SpurImageTestResource imageNameForTests extraMemory: 0]
		raise: Error