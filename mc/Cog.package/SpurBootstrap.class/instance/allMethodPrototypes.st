method prototypes
allMethodPrototypes
	"Answer all prototype selectors, including those marked <remove>"
	^(imageTypes 
		inject: (IdentitySet withAll: SpurBootstrapPrototypes allMethodPrototypes)
		into: [:allPrototypes :type | | prototypes |
			prototypes := (SpurBootstrapPrototypes prototypeClassFor: type) allMethodPrototypes.
			allPrototypes
				removeAllSuchThat: [:existing| prototypes anySatisfy: [:new| existing selector == new selector]];
				addAll: (prototypes reject: [:prototype| (prototype pragmaAt: #ignore) notNil]);
				yourself])
		asArray sort: [:ma :mb| ma selector <= mb selector]