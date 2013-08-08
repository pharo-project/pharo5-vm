return bytecodes
returnTopFromBlock
	"Return to the caller of the current block activation."
	localReturnValue := self internalStackTop.
	self commonCallerReturn