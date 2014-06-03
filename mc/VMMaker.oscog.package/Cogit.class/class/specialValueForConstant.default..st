translation
specialValueForConstant: constantName default: defaultValue
	constantName = 'Debug' ifTrue: [^'DEBUGVM'].
	^CoInterpreter specialValueForConstant: constantName default: defaultValue