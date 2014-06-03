initialization
initializeMiscConstants

	super initializeMiscConstants.
	NewspeakVM := true.
	IMMUTABILITY := initializationOptions at: #IMMUTABILITY ifAbsent: [true].

	PrimitiveExternalCallIndex := 117. "Primitive index for #primitiveExternalCall"
	MillisecondClockMask := 16r1FFFFFFF.
	"Note: The external primitive table should actually be dynamically sized but for the sake of inferior platforms (e.g., Mac :-) who cannot allocate memory in any reasonable way, we keep it static (and cross our fingers...)"
	MaxExternalPrimitiveTableSize := 1024. "entries"

	FailImbalancedPrimitives ifNil: [FailImbalancedPrimitives := false].
	RecordPrimTrace := false.
	RecordSendTrace := false.
	TraceLogSize := 256