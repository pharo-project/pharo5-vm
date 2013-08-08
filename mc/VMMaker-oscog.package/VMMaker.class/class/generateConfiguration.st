configurations
generateConfiguration
	"VMMaker generateConfiguration"
	| configCategoryName selectors |
	configCategoryName := self class whichCategoryIncludesSelector: thisContext selector.
	selectors := Set new.
	self class organization categories do:
		[:cat|
		(cat endsWith: configCategoryName) ifTrue:
			[selectors addAll: (self class organization listAtCategoryNamed: cat)]].
	selectors remove: thisContext selector.
	selectors := selectors asArray sort.
	(UIManager default
			chooseFrom: (selectors collect:
							[:sel| (sel piecesCutWhere: [:a :b| a isLowercase and: [b isUppercase]]) allButFirst
									fold: [:a :b| a, ' ', b]])
			values: selectors) ifNotNil:
		[:choice|
		self perform: choice]