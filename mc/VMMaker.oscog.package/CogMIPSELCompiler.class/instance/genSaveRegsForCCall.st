abi
genSaveRegsForCCall
	"Save the general purpose registers for a call into the C run-time from a trampoline.
	 We don't need to do anything because all of the abstract registers are
	 allocated to C preserved registers."
	self flag: 'this will change with Sista when we hope to be able to allocate arbitrary registers'