initialization
initializeMiscConstants

	super initializeMiscConstants.
	COGVM := true.

	MinBackwardJumpCountForCompile := 40.

	MaxNumArgs := 15.
	PrimCallNeedsNewMethod := 1.
	PrimCallNeedsPrimitiveFunction := 2.
	PrimCallMayCallBack := 4.
	PrimCallCollectsProfileSamples := 8.
	CheckAllocationFillerAfterPrimCall := 16.
	PrimCallDoNotJIT := 32.

	ReturnToInterpreter := 1. "setjmp/longjmp code."

	PrimTraceLogSize := 256. "Room for 256 selectors.  Must be 256 because we use a byte to hold the index"
	TraceBufferSize := 256 * 3. "Room for 256 events"
	TraceContextSwitch := self objectMemoryClass basicNew integerObjectOf: 1.
	TraceBlockActivation := self objectMemoryClass basicNew integerObjectOf: 2.
	TraceBlockCreation := self objectMemoryClass basicNew integerObjectOf: 3.
	TraceIncrementalGC := self objectMemoryClass basicNew integerObjectOf: 4.
	TraceFullGC := self objectMemoryClass basicNew integerObjectOf: 5.
	TraceCodeCompaction := self objectMemoryClass basicNew integerObjectOf: 6.
	TraceOwnVM := self objectMemoryClass basicNew integerObjectOf: 7.
	TraceDisownVM := self objectMemoryClass basicNew integerObjectOf: 8.
	TraceThreadSwitch := self objectMemoryClass basicNew integerObjectOf: 9.
	TracePreemptDisowningThread := self objectMemoryClass basicNew integerObjectOf: 10.
	TraceVMCallback := self objectMemoryClass basicNew integerObjectOf: 11.
	TraceVMCallbackReturn := self objectMemoryClass basicNew integerObjectOf: 12.
	TraceStackOverflow := self objectMemoryClass basicNew integerObjectOf: 13.
	TracePrimitiveFailure := self objectMemoryClass basicNew integerObjectOf: 14.
	TracePrimitiveRetry := self objectMemoryClass basicNew integerObjectOf: 15.

	TraceIsFromMachineCode := 1.
	TraceIsFromInterpreter := 2.
	CSCallbackEnter := 3.
	CSCallbackLeave := 4.
	CSEnterCriticalSection := 5.
	CSExitCriticalSection := 6.
	CSResume := 7.
	CSSignal := 8.
	CSSuspend := 9.
	CSWait := 10.
	CSYield := 11.
	CSCheckEvents := 12.
	CSThreadSchedulingLoop := 13.
	CSOwnVM := 14.
	CSThreadBind := 15.
	CSSwitchIfNeccessary := 16.

	TraceSources := CArrayAccessor on: #('?' 'm' 'i' 'callbackEnter' 'callbackLeave' 'enterCritical' 'exitCritical' 'resume' 'signal'  'suspend' 'wait' 'yield' 'eventcheck' 'threadsched' 'ownVM' 'bindToThread' 'switchIfNecessary').

	"this is simulation only"
	RumpCStackSize := 4096