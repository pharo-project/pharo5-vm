instance creation
named: aName config: aCPlatformConfig

	^ (self allSubclasses detect: [:cls | 
		cls canonicalName = aName and: [ cls supports: aCPlatformConfig ] ])
		new