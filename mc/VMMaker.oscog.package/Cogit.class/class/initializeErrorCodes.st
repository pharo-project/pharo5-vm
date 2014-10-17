class initialization
initializeErrorCodes
	"External errors, returned to or from cog:selector:"
	NotFullyInitialized := -1.
	InsufficientCodeSpace := -2.
	MethodTooBig := -4.
	YoungSelectorInPIC := -5.
	EncounteredUnknownBytecode := -6.
	UnimplementedPrimitive := -7.
	ShouldNotJIT := -8.
	MaxNegativeErrorCode := ShouldNotJIT.
	"Internal errors returned by generator routines to other generator routines"
	BadRegisterSet := 1