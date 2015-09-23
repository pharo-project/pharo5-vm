debug support
runLeakCheckerFor: gcModes excludeUnmarkedNewSpaceObjs: excludeUnmarkedNewSpaceObjs classIndicesShouldBeValid: classIndicesShouldBeValid
	(coInterpreter displayView isNil
	 and: [gcModes anyMask: checkForLeaks]) ifTrue:
		[coInterpreter transcript nextPutAll: 'leak-checking...'; flush].
	^super
		runLeakCheckerFor: gcModes
		excludeUnmarkedNewSpaceObjs: excludeUnmarkedNewSpaceObjs
		classIndicesShouldBeValid: classIndicesShouldBeValid