class initialization
initialize
	"GdbARMAlien initialize"

	PostBuildStackDelta := 0.

	"Return errors from GdbARMPlugin.h"
	NoError := 0.
	ExecutionError := 1.
	BadCPUInstance := 2.
	MemoryLoadBoundsError := 3.
	MemoryWriteBoundsError := 4.
	InstructionPrefetchError := 5.
	PanicError := 6.
	UnsupportedOperationError := 7.
	SomethingLoggedError := 8