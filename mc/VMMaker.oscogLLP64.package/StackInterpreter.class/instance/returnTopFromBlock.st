return bytecodes
returnTopFromBlock
	"Return top-of-stack to the caller of the current block activation."
	localReturnValue := self internalStackTop.
	self commonCallerReturn