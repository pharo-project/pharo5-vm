translation
requiredMethodNames
	"self requiredMethodNames"
	^super requiredMethodNames
		add: self isPushNilFunction;
		add: self pushNilSizeFunction;
		yourself