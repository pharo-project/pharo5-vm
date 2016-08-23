in-line cacheing
compileOpenPIC: selector numArgs: numArgs
	"Compile the code for an open PIC.  Perform a probe of the first-level method
	 lookup cache followed by a call of ceSendFromOpenPIC: if the probe fails.
	 Since open PICs replicate the CoInterpreter's first-level method cache lookup
	 this is a subclass responsibility."
	self subclassResponsibility