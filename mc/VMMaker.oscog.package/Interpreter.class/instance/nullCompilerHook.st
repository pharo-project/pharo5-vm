compiler support
nullCompilerHook
	"This should never be called: either the compiler is uninitialised (in which case the hooks should never be reached) or the compiler initialisation should have replaced all the hook with their external implementations."

	self error: 'uninitialised compiler hook called'.
	^false