object memory support
preGCAction: gcModeArg
	<inline: false>
	"Need to write back the frame pointers unless all pages are free (as in snapshot).
	 Need to set gcMode var (to avoid passing the flag through a lot of the updating code)"
	super preGCAction: gcModeArg.

	gcMode := gcModeArg.

	cogit recordEventTrace ifTrue:
		[| traceType |
		traceType := gcModeArg == GCModeFull ifTrue: [TraceFullGC] ifFalse: [TraceIncrementalGC].
		self recordTrace: traceType thing: traceType source: 0].

	cogit recordPrimTrace ifTrue:
		[| traceType |
		traceType := gcModeArg == GCModeFull ifTrue: [TraceFullGC] ifFalse: [TraceIncrementalGC].
		self fastLogPrim: traceType]