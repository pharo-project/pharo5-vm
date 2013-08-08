return bytecodes
returnTopFromBlock
	"Return to the caller of the method containing the block."
	localReturnContext := self caller.  "Note: caller, not sender!"
	localReturnValue := self internalStackTop.
	self commonReturn.