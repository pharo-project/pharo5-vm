stack bytecodes
pushActiveContextBytecode
	"Puts reclaimability of this context in question."

	self fetchNextBytecode.
	reclaimableContextCount := 0.
	self internalPush: activeContext.
