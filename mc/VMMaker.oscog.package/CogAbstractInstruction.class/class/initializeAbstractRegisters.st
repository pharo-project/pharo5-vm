class initialization
initializeAbstractRegisters
	"Assign the abstract registers with the identities/indices of the relevant concrete registers.
	 First set all abstract registers to #undefined via CogAbstractRegisters initialize, and then,
	 each subclasses assigns the subset they choose with values of specific concrete registers."
	CogAbstractRegisters initialize