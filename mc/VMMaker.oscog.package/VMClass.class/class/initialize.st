initialization
initialize
	(Utilities classPool at: #CommonRequestStrings ifAbsent: []) ifNotNil:
		[:commonRequestStringHolder|
		(commonRequestStringHolder contents asString includesSubString: 'VMClass open') ifFalse:
			[Utilities appendToCommonRequests: '-\VMMaker generateConfiguration\VMMaker generateAllConfigurationsUnderVersionControl\VMMaker generateAllSpurConfigurations\VMClass openCogMultiWindowBrowser\VMClass openObjectMemoriesInterpretersBrowser\VMClass openSpurMultiWindowBrowser\VMClass openCogSpurMultiWindowBrowser' withCRs]].
	ExpensiveAsserts := false