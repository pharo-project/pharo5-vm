accessing method dictionary
allMethodPrototypes
	^(self canUnderstand: #allMethods)
		ifTrue: "Pharo"
			[self allMethods select:
				[:each| each category = 'method prototypes']]
		ifFalse: "Squeak" "%$#@*! collect: on IdentitySet answers a *Set*, not an IdentitySet %$#@*!"
			[(self allSelectors collect: [:s| self lookupSelector: s] as: IdentitySet)
				select: [:m| m protocol = 'method prototypes']]