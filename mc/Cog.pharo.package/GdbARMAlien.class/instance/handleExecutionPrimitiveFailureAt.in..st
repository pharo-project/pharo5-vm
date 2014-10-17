error handling
handleExecutionPrimitiveFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>"
	"Handle an execution primitive failure for an otherwise unhandled opcode."
	^self reportPrimitiveFailure