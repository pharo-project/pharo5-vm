public access
on: imageName
	(interpreter32 := StackInterpreterSimulator newWithOptions: #(ObjectMemory Spur32BitMemoryManager))
		openOn: imageName extraMemory: 0.
	heap32 := interpreter32 objectMemory.
	imageHeaderFlags := interpreter32 getImageHeaderFlags.
	savedWindowSize := interpreter32 savedWindowSize.
	interpreter64 := StackInterpreterSimulator newWithOptions: #(ObjectMemory Spur64BitMemoryManager).
	heap64 := interpreter64 objectMemory.
	heap64
		allocateMemoryOfSize: heap32 oldSpaceSize * 2
		newSpaceSize: 8 * 1024 * 1024
		stackSize: 16 * 1024
		codeSize: 0.
	heap64 bootstrapping: true.
	self initMaps