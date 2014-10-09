accessing class hierarchy
cogitClass
	^initializationOptions ifNotNil:
		[Smalltalk classNamed: (initializationOptions
									at: #Cogit
									ifAbsent: [#SimpleStackBasedCogit])]