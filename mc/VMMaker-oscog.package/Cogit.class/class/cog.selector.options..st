in-image compilation
cog: aCompiledMethod selector: aSelector options: optionsDictionaryOrArray
	"StackToRegisterMappingCogit cog: (Integer >> #benchFib) selector: #benchFib options: #(COGMTVM false)"
	| coInterpreter cogit |
	self initializeWithOptions: (self asOptionsDictionary: optionsDictionaryOrArray).
	coInterpreter := CurrentImageCoInterpreterFacade new cogit: (cogit := self new); yourself.
	[cogit
		setInterpreter: coInterpreter;
		singleStep: true;
		initializeCodeZoneFrom: 1024 upTo: coInterpreter memory size.
	 cogit methodZone freeStart: (cogit methodZone freeStart roundUpTo: 1024)]
		on: Notification
		do: [:ex|
			(ex messageText beginsWith: 'cannot find receiver for') ifTrue:
				[ex resume: coInterpreter].
			ex pass].
	^{ coInterpreter.
		cogit.
		cogit cog: (coInterpreter oopForObject: aCompiledMethod) selector: (coInterpreter oopForObject: aSelector) }