return bytecodes
returnNilFromBlock
	"Return nil to the caller of the current block activation."
	localReturnValue := objectMemory nilObject.
	self commonCallerReturn