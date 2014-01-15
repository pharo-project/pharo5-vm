translation
exportAPISelectors
	^((self withAllSuperclasses copyUpThrough: Cogit), self ancilliaryClasses collect:
		[:c| self exportAPISelectorsFor: c]) fold: [:a :b| a, b]