translation
exportAPISelectors
	| omExports |
	omExports := (self objectMemoryClass withAllSuperclasses copyUpTo: VMClass)
					inject: Set new
					into: [:api :c| api addAll: c exportAPISelectors; yourself].
	^(self withAllSuperclasses copyUpTo: VMClass), self ancilliaryClasses
		inject: omExports
		into: [:set :class| set addAll: (self exportAPISelectorsFor: class); yourself]