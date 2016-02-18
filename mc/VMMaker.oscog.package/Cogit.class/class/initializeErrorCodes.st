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
	BadRegisterSet := 1.
	UnimplementedOperation := 2.
	"Internal successes answered by CogObjectRepresentation to JIT, etc"
	UnfailingPrimitive := 3. "Answered by a primitive generator for a primitive that will never fail"
	CompletePrimitive := 4 "Answered by a primitive generator that does not bneed to fall back on the interpreter primitive except for an error code."