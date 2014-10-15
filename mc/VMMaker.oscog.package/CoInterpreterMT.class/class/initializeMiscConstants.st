initialization
initializeMiscConstants

	super initializeMiscConstants.

	"N.B. some of these DisownFlags are replicated in platforms/Cross/vm/sqVirtualMachine.h.
	 Hence they should always be initialized."
	DisownVMLockOutFullGC := 1.
	DisownVMForProcessorRelinquish := 2.

	(initializationOptions notNil
	 and: [(initializationOptions at: #COGMTVM ifAbsent: [false]) == false]) ifTrue:
		[^self].

	COGMTVM := true.

	ReturnToThreadSchedulingLoop := 2. "setjmp/longjmp code."