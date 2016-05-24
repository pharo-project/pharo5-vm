initialization
initializeMiscConstants

	super initializeMiscConstants.
	STACKVM := true.

	"These flags function to identify a GC operation, or
	 to specify what operations the leak checker should be run for."
	GCModeFull := 1.				"stop-the-world global GC"
	GCModeNewSpace := 2.		"Spur's scavenge, or V3's incremental"
	GCModeIncremental := 4.		"incremental global gc (Dijkstra tri-colour marking); as yet unimplemented"
	GCModeBecome := 8.			"v3 post-become sweeping/Spur forwarding"
	GCModeImageSegment := 16.	"just a flag for leak checking image segments"
	GCModeFreeSpace := 32.		"just a flag for leak checking free space; Spur only"
	GCCheckPrimCall := 64.		"just a flag for leak checking external primitive calls"

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
	FailImbalancedPrimitives := initializationOptions at: #FailImbalancedPrimitives ifAbsentPut: [true].
	EnforceAccessControl := initializationOptions at: #EnforceAccessControl ifAbsent: [true]