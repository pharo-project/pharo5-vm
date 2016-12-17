public access
on: imageName
	(oldInterpreter := StackInterpreterSimulator newWithOptions: #(ObjectMemory Spur32BitMemoryManager))
		openOn: imageName extraMemory: 0.
	oldHeap := oldInterpreter objectMemory.
	imageHeaderFlags := oldInterpreter getImageHeaderFlags.
	savedWindowSize := oldInterpreter savedWindowSize.
	newInterpreter := StackInterpreterSimulator newWithOptions: #(ObjectMemory Spur32BitMemoryManager).
	newHeap := newInterpreter objectMemory.
	newHeap
		allocateMemoryOfSize: oldHeap oldSpaceSize
		newSpaceSize: 8 * 1024 * 1024
		stackSize: 16 * 1024
		codeSize: 0.
	newHeap bootstrapping: true.
	self initMaps