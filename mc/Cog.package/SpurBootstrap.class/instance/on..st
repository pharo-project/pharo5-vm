initialize-release
on: imageName
	StackInterpreter initializeWithOptions: Dictionary new.
	(oldInterpreter := StackInterpreterSimulator new)
		openOn: imageName extraMemory: 0;
		assertValidExecutionPointersAtEachStep: false.
	oldHeap := oldInterpreter objectMemory.
	newHeap := Spur32BitMMLESimulator new.
	newHeap
		allocateMemoryOfSize: (oldHeap youngStart * 3 / 2 roundUpTo: 1024 * 1024)
		newSpaceSize: 4 * 1024 * 1024
		stackSize: 16 * 1024
		codeSize: 0.
	newHeap setCheckForLeaks: 15 - 6. "don't check become; or newSpace; soooo many rehashes in bootstrap"
	newHeap bootstrapping: true.
	self initMaps