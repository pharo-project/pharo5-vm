bytecode generator support
genGetInstanceOf: classObj into: destReg initializingIf: initializeInstance
	"Create an instance of classObj and assign it to destReg, initializing the instance
	 if initializeInstance is true with nil or 0 as appropriate This is for inline primitives.
	 Assume there is sufficient space in new space to complete the operation.
	 Answer zero on success."
	self subclassResponsibility