translation
mustBeGlobal: var
	"Answer if a variable must be global and exported.  Used for inst vars that are accessed from VM support code."

	^(super mustBeGlobal: var)
	   or: ['checkForLeaks' = var]