method prototypes
allPrototypeMethods
	^imageTypes
		inject: (SpurBootstrap class organization listAtCategoryNamed: #'method prototypes')
		into: [:prototypes :type|
			prototypes, (SpurBootstrap class organization listAtCategoryNamed: #'method prototypes ', type)]