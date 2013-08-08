settings
configurationFlags 
	^(configurationFlags 
		ifNil: [ self defaultConfigurationFlags ])
		reduce: [ :a :b | a, ' ', b]