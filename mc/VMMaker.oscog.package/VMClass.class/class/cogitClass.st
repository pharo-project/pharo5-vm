accessing class hierarchy
cogitClass
	"Answer the cogitClass in effect.  Ensure that StackInterpreter has a nil cogitClass."
	(self isInterpreterClass and: [self hasCogit not]) ifTrue:
		[^nil].
	^initializationOptions ifNotNil:
		[Smalltalk classNamed: (initializationOptions
									at: #Cogit
									ifAbsent: [#SimpleStackBasedCogit])]