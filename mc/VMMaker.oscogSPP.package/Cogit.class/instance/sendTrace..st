debugging
sendTrace: aBooleanOrInteger
	<doNotGenerate>
	"traceFlags is a set of flags.
	 1 => print trace (if something below is selected)
	 2 => trace sends
	 4 => trace block activations
	 8 => trace interpreter primitives
	 16 => trace events (context switches, GCs, etc)
	 32 => trace stack overflow
	 64 => send breakpoint on implicit receiver (Newspeak VM only)
	128 => check stack depth on send (simulation only)
	256 => count sends (simulation only)"
	traceFlags := aBooleanOrInteger isInteger
							ifTrue: [aBooleanOrInteger]
							ifFalse: [aBooleanOrInteger ifTrue: [6] ifFalse: [0]]