translation
exportAPISelectors: options
	"Yes this is a mess.  When all exportAPI methods are marked with the <api> pragma
	 this can go away."
	| omExports |
	omExports := (self objectMemoryClass withAllSuperclasses copyUpTo: VMClass)
					inject: Set new into: [:api :c| api addAll: (c exportAPISelectors: options); yourself].
	^(self withAllSuperclasses copyUpTo: VMClass), (self ancilliaryClasses: options)
		inject: omExports
		into: [:set :class| set addAll: (self exportAPISelectorsFor: class); yourself]