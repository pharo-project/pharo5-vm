initialization
initializeMiscConstants

	super initializeMiscConstants.
	STACKVM := true.

	GCModeFull := 1.
	GCModeIncr := 2.
	GCModeScavenge := 3.
	GCModeBecome := 4.

	StackPageTraceInvalid := -1.
	StackPageUnreached := 0.
	StackPageReachedButUntraced := 1.
	StackPageTraced := 2.

	DumpStackOnLowSpace := 0.
	PrimitiveExternalCallIndex := 117. "Primitive index for #primitiveExternalCall"
	MillisecondClockMask := 16r1FFFFFFF.
	"Note: The external primitive table should actually be dynamically sized but for the sake of inferior platforms (e.g., Mac :-) who cannot allocate memory in any reasonable way, we keep it static (and cross our fingers...)"
	MaxExternalPrimitiveTableSize := 4096. "entries"

	MaxJumpBuf := 32. "max. callback depth"
	FailImbalancedPrimitives := true