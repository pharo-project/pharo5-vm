debug support
runLeakCheckerFor: gcModes excludeUnmarkedObjs: excludeUnmarkedObjs classIndicesShouldBeValid: classIndicesShouldBeValid
	(coInterpreter displayView isNil
	 and: [gcModes anyMask: checkForLeaks]) ifTrue:
		[coInterpreter transcript nextPutAll: 'leak-checking...'; flush].
	^super
		runLeakCheckerFor: gcModes
		excludeUnmarkedObjs: excludeUnmarkedObjs
		classIndicesShouldBeValid: classIndicesShouldBeValid