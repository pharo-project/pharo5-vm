bytecode generator support
genCreateFullClosure: compiledBlock numArgs: numArgs numCopied: numCopied ignoreContext: ignoreContext contextNumArgs: contextNumArgs large: contextIsLarge inBlock: contextIsBlock
	"Create a full closure"
	self subclassResponsibility