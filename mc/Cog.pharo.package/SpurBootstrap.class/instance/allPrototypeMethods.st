method prototypes
allPrototypeMethods
	^ (SpurBootstrap class organization listAtCategoryNamed: #'method prototypes'),
	(SpurBootstrap class organization listAtCategoryNamed: #'method prototypes ', imageType)