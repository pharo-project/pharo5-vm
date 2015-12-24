class initialization
initializeAbstractRegisters
	"Assign the abstract registers with the identities/indices of the relevant concrete registers."
	self ~~ CogX64Compiler ifTrue:
		[self subclassResponsibility]