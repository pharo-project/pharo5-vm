rump c stack
isOnRumpCStack: address
	^address between: heapBase - self rumpCStackSize and: heapBase - objectMemory wordSize