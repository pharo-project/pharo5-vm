debug support
setUpForUseByFacade: aCurrentImageCoInterpreterFacade
	"Set up variables with default values so that other initializations work.
	 numStackPages needs to be initialized so that interpreterAllocationReserveBytes
	 can be computed."
	<doNotGenerate>
	numStackPages := 0