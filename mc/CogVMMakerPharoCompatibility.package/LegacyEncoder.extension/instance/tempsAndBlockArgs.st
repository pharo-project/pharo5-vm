*CogVMMakerPharoCompatibility
tempsAndBlockArgs
	| tempNodes |
	tempNodes := OrderedCollection new.
	scopeTable associationsDo:
		[:assn | | var |
		var := assn value.
		(var isTemp
		 and: [var isMethodArg not
		 and: [var scope = 0 or: [var scope = -1]]]) ifTrue:
			[tempNodes add: var]].
	^tempNodes