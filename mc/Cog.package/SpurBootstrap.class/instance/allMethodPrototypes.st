method prototypes
allMethodPrototypes
	"Answer all prototype selectors, including those marked <remove>"
	^imageTypes 
		inject: Set new 
		into: [:prototypes :type |
				prototypes 
					addAll: ((SpurBootstrapPrototypes prototypesFor: type) allMethodPrototypes);
					yourself ]