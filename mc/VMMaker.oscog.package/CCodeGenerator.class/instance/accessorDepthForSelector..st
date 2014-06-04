spur primitive compilation
accessorDepthForSelector: selector
	^(selector = #initialiseModule
	   or: [InterpreterPlugin includesSelector: selector]) ifFalse:
		[(self methodNamed: selector) ifNotNil:
			[:m| self accessorDepthForMethod: m]]