initialize-release
initializeModuleForPlatform
	"Platform specific initialization"

	pidCount := 0.
	self cCode: [self atexit: #sendSignalToPids]
		inSmalltalk:
			[semaIndices := CArrayAccessor on: (Array new: 32 withAll: 0).
			originalSigHandlers := CArrayAccessor on: (Array new: 32 withAll: 0)].
	vmThread := self cCode: 'pthread_self()' inSmalltalk: [30rTHREAD].
	useSignalStack := -1