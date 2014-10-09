accessing class hierarchy
cogitClass
	^Smalltalk classNamed: (initializationOptions
								at: #Cogit
								ifAbsent: [#SimpleStackBasedCogit])