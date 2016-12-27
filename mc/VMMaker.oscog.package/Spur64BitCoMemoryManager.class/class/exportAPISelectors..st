translation
exportAPISelectors: options
	^(Set withAll: (self exportAPISelectorsFor: self))
		addAll: (SpurGenerationScavenger exportAPISelectors: options);
		addAll: (self compactorClass exportAPISelectors: options);
		yourself