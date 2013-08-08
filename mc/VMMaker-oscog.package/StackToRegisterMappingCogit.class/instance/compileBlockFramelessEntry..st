compile abstract instructions
compileBlockFramelessEntry: blockStart
	"Make sure ReceiverResultReg holds the receiver, loaded from
	 the closure, which is what is initially in ReceiverResultReg"
	<var: #blockStart type: #'BlockStart *'>
	methodOrBlockNumTemps := blockStart numArgs + blockStart numCopied + blockStart numInitialNils.
	self initSimStackForFramelessBlock: blockStart startpc.
	super compileBlockFramelessEntry: blockStart