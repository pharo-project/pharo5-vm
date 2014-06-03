utilities
checkForGlobalUsage: vars in: aTMethod 
	"override to handle global struct needs"
	super checkForGlobalUsage: vars in: aTMethod.

	vars asSet do:
		[:var |
		"if any var is global and in the global var struct 
		tell the TMethod it may be refering to the  struct, depending upon the #defines"
		 ((variables includes: var)
		  and: [self placeInStructure: var]) ifTrue:
			[aTMethod referencesGlobalStruct]]