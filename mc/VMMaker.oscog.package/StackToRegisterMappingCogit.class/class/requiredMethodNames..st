translation
requiredMethodNames: options
	^(super requiredMethodNames: options)
		add: self isPushNilFunction;
		add: self pushNilSizeFunction;
		yourself