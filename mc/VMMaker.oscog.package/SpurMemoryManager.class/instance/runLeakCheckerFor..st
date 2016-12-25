debug support
runLeakCheckerFor: gcModes
	<inline: false>
	^self
		inLineRunLeakCheckerFor: gcModes
		excludeUnmarkedObjs: false
		classIndicesShouldBeValid: true