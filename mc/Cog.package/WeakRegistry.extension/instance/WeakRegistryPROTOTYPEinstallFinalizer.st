*Cog-method prototypes
WeakRegistryPROTOTYPEinstallFinalizer
	valueDictionary finalizer: [ :executor | 
		executors ifNil: [ executors := OrderedCollection new ].
		executors add: executor ]