translation
requiredMethodNames: options
	^(super requiredMethodNames: options)
		add: self numPushNilsFunction;
		add: self pushNilSizeFunction;
		yourself