initialization
initPastSpaceForObjectEnumeration
	"For SuurMemoryManager allNewSpaceObjectsDo: fill pastSpace with
	 a single empty object."
	| objOop |
	manager initFreeChunkWithBytes: pastSpace limit - pastSpace start at: pastSpace start.
	objOop := manager objectStartingAt: pastSpace start.
	self assert: (manager addressAfter: objOop) = pastSpace limit