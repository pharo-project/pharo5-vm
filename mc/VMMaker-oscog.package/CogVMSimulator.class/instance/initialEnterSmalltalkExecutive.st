initialization
initialEnterSmalltalkExecutive
	"Main entry-point into the interpreter at system start-up.
	 Override to choose between the threaded and non-threaded versions and if threaded
	 to ensure that the switch method overrides are up-to-date."
	self ensureMultiThreadingOverridesAreUpToDate.
	^self perform: #initialEnterSmalltalkExecutive
		withArguments: {}
		inSuperclass: (cogThreadManager ifNil: [CoInterpreterPrimitives] ifNotNil: [CoInterpreterMT])