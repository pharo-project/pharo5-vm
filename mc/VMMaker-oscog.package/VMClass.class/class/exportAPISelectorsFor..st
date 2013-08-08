translation
exportAPISelectorsFor: aClass
	^(aClass selectors select:
		[:s| | m |
		((m := aClass compiledMethodAt: s) pragmaAt: #api) notNil or: [(m pragmaAt: #api:) notNil]]) asSet