defaults
defaultOutputDestination
	^ Smalltalk at:       #ScriptConsole
	            ifAbsent: [SMarkReporter defaultOutputDestination]