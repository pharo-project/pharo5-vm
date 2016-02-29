debug support
inLineRunLeakCheckerFor: gcModes excludeUnmarkedNewSpaceObjs: excludeUnmarkedNewSpaceObjs classIndicesShouldBeValid: classIndicesShouldBeValid
	<inline: true>
	(gcModes anyMask: checkForLeaks) ifTrue:
		[(gcModes anyMask: GCModeFull)
			ifTrue: [coInterpreter reverseDisplayFrom: 0 to: 7]
			ifFalse: [coInterpreter reverseDisplayFrom: 8 to: 15].
		 self clearLeakMapAndMapAccessibleObjects.
		 self asserta: (self checkHeapIntegrity: excludeUnmarkedNewSpaceObjs classIndicesShouldBeValid: classIndicesShouldBeValid).
		 self asserta: coInterpreter checkInterpreterIntegrity.
		 self asserta: coInterpreter checkStackIntegrity.
		 self asserta: (coInterpreter checkCodeIntegrity: gcModes)]