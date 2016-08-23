translation
exportAPISelectors: options
	^((self withAllSuperclasses copyUpThrough: Cogit), (self ancilliaryClasses: options) collect:
		[:c| self exportAPISelectorsFor: c]) fold: [:a :b| a, b]