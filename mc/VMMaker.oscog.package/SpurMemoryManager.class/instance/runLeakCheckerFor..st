debug support
runLeakCheckerFor: gcModes
	<inline: false>
	^self
		inLineRunLeakCheckerFor: gcModes
		excludeUnmarkedNewSpaceObjs: false
		classIndicesShouldBeValid: true