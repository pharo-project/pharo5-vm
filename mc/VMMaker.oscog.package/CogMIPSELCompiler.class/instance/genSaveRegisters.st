abi
genSaveRegisters
	"This method is poorly named. Is this for a Smalltalk -> C call or C -> Smalltalk call?
	 If the former we don't need to do anything because all of the abstract registers are
	 allocated to C preserved registers."
	self flag: #bogus.