method prototypes
allPrototypeSelectors
	"Answer all prototype selectors, including those marked <remove>"
	^imageTypes
		inject: (SpurBootstrap class organization listAtCategoryNamed: #'method prototypes')
		into: [:prototypes :type|
				prototypes, (SpurBootstrap class organization listAtCategoryNamed: #'method prototypes ', type)]