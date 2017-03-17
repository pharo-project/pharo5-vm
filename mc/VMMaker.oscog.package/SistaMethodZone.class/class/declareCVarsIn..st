translation
declareCVarsIn: aCCodeGenerator
	aCCodeGenerator
		declareVar: 'allocationThreshold' type: #usqInt;
		var: 'thresholdRatio' declareC: (BytesPerWord = 8 ifTrue: ['double thresholdRatio = 0.5'] ifFalse: ['float thresholdRatio = 0.5f'])