error handling
handleExecutionPrimitiveFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>" readOnlyBelow: minimumWritableAddress "<Integer>"
	"Handle an execution primitive failure for an unhandled opcode."
	^self reportPrimitiveFailure