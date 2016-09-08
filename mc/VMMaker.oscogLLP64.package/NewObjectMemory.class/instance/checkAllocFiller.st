allocation
checkAllocFiller
	<doNotGenerate>
	"in the Spur bootstrap coInterpreter may not be initialized..."
	^coInterpreter notNil and: [coInterpreter checkAllocFiller]