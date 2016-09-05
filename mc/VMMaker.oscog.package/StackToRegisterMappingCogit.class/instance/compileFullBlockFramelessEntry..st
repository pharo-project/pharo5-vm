compile abstract instructions
compileFullBlockFramelessEntry: numCopied
	"Make sure ReceiverResultReg holds the receiver, loaded from
	 the closure, which is what is initially in ReceiverResultReg"
	self initSimStackForFramelessBlock: initialPC.
	super compileFullBlockFramelessEntry: numCopied