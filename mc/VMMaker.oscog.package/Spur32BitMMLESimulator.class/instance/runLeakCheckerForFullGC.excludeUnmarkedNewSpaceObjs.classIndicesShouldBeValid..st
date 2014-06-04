debug support
runLeakCheckerForFullGC: fullGCFlag excludeUnmarkedNewSpaceObjs: excludeUnmarkedNewSpaceObjs classIndicesShouldBeValid: classIndicesShouldBeValid
	(coInterpreter displayView isNil
	 and: [fullGCFlag
			ifTrue: [self leakCheckFullGC]
			ifFalse: [self leakCheckNewSpaceGC]]) ifTrue:
		[coInterpreter transcript nextPutAll: 'leak-checking...'; flush].
	^super
		runLeakCheckerForFullGC: fullGCFlag
		excludeUnmarkedNewSpaceObjs: excludeUnmarkedNewSpaceObjs
		classIndicesShouldBeValid: classIndicesShouldBeValid