bytecode generator support
genGetActiveContextNumArgs: numArgs large: isLargeContext inBlock: isInBlock
	"Get the active context into ReceiverResultReg, creating it if necessary."
	self subclassResponsibility