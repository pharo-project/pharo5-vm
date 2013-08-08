initialization
initializeMiscConstantsWith: optionsDictionary

	super initializeMiscConstantsWith: optionsDictionary.
	COGMTVM := true.

	ReturnToThreadSchedulingLoop := 2. "setjmp/longjmp code."

	"N.B. some of these DisownFlags are replicated in platforms/Cross/vm/sqVirtualMachine.h"
	DisownVMLockOutFullGC := 1.
	DisownVMForProcessorRelinquish := 2