bootstrap image
initializeClasses
	toBeInitialized ifNil: [^self].
	self withExecutableInterpreter: oldInterpreter
		do: [toBeInitialized do:
				[:class|
				self interpreter: oldInterpreter
					object: (self oldClassOopFor: class)
					perform: (self findSymbol: #initialize)
					withArguments: #()]]