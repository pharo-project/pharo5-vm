tests
testSimulatorCanReloadImage
	self shouldnt:
			[(StackInterpreterSimulator newWithOptions: #(ObjectMemory Spur32BitMemoryManager))
				openOn: self class imageNameForTests extraMemory: 0;
				openOn: self class imageNameForTests extraMemory: 0]
		raise: Error