error handling
handleExecutionPrimitiveFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>" rex: rexByteOrNil "<Integer|nil>"
	"Handle an execution primitive failure for an unhandled opcode."
	^self reportPrimitiveFailure