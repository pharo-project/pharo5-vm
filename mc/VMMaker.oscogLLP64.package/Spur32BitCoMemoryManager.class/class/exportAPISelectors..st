translation
exportAPISelectors: options
	^(Set withAll: (self exportAPISelectorsFor: self))
		addAll: (SpurGenerationScavenger exportAPISelectors: options);
		yourself