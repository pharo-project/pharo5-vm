instance creation
initialize

	Smalltalk at: #TheWorldMenu ifPresent: [ :class |
		((class compiledMethodAt: #registerOpenCommand: ifAbsent: [^self]) sendsSelector: #deprecated:) 
			ifFalse: [class registerOpenCommand: (Array with: 'VMMaker' with: (Array with: self with: #openInWorld))]]
	