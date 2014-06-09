in-image compilation
cog: aCompiledMethod selector: aSelector options: optionsDictionaryOrArray
	"StackToRegisterMappingCogit cog: (Integer >> #benchFib) selector: #benchFib options: #(COGMTVM false)"
	| coInterpreter cogit |
	self initializeWithOptions: (self asOptionsDictionary: optionsDictionaryOrArray).
	CoInterpreter initializeWithOptions: initializationOptions.
	CoInterpreter objectMemoryClass initializeWithOptions: initializationOptions.
	coInterpreter := CurrentImageCoInterpreterFacade forCogit: (cogit := self new).
	[cogit
		setInterpreter: coInterpreter;
		singleStep: true;
		initializeCodeZoneFrom: 1024 upTo: coInterpreter memory size / 2. "leave space for rump C stack"
	 cogit methodZone freeStart: (cogit methodZone freeStart roundUpTo: 1024)]
		on: Notification
		do: [:ex|
			(ex messageText beginsWith: 'cannot find receiver for') ifTrue:
				[ex resume: coInterpreter].
			ex pass].
	^{ coInterpreter.
		cogit.
		cogit cog: (coInterpreter oopForObject: aCompiledMethod) selector: (coInterpreter oopForObject: aSelector) }