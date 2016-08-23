debug support
setUpForUseByFacade: aCurrentImageCoInterpreterFacade
	"Make sure that eden etc are initialized, so that methods can be printed.
	 This is really to make addressCouldBeObj: et al work."
	<doNotGenerate>
	self edenBytes: 0.
	self setHeapBase: self freeStart
		memoryLimit: self endOfMemory
		endOfMemory: self endOfMemory