initialize-release
on: imageName
	StackInterpreter initializeWithOptions: Dictionary new.
	oldInterpreter := StackInterpreterSimulator new.
	oldInterpreter openOn: imageName extraMemory: 0.
	oldHeap := oldInterpreter objectMemory.
	newHeap := Spur32BitMMLESimulator new.
	newHeap
		allocateMemoryOfSize: (oldHeap youngStart * 3 / 2 roundUpTo: 1024 * 1024)
		newSpaceSize: 1024 * 1024
		codeSize: 1024 * 1024.
	newHeap setCheckForLeaks: 15 - 4. "don't check become; soooo many rehashes in bootstrap"
	map := Dictionary new: oldHeap memory size // 4.
	reverseMap := Dictionary new: oldHeap memory size // 4.
	classToIndex := Dictionary new: 1024.
	literalMap := IdentityDictionary new.
	methodClasses := Set new.
	installedPrototypes := Set new