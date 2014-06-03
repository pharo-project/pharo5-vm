class initialization
initialize
	"c.f. ExternalFunction allInstVarNames
		old: #('handle' 'flags' 'argTypes')
		new: #('handle' 'flags' 'argTypes' 'stackSize')"
	ExternalFunctionAddressIndex := 0.
	ExternalFunctionFlagsIndex := 1.
	ExternalFunctionArgTypesIndex := 2.
	ExternalFunctionStackSizeIndex := 3.

	"c.f. e.g. CoInterpreter class initializeMiscConstants"
	MaxNumArgs := 15.

	DefaultMaxStackSize := 1024 * 16