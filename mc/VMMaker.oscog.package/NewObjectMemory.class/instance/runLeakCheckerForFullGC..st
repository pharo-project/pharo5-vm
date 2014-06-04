debug support
runLeakCheckerForFullGC: fullGCFlag
	<inline: false>
	(fullGCFlag
			ifTrue: [self leakCheckFullGC]
			ifFalse: [self leakCheckNewSpaceGC]) ifTrue:
		[fullGCFlag
			ifTrue: [coInterpreter reverseDisplayFrom: 0 to: 7]
			ifFalse: [coInterpreter reverseDisplayFrom: 8 to: 15].
		 self clearLeakMapAndMapAccessibleObjects.
		 self assert: self checkHeapIntegrity.
		 self assert: coInterpreter checkInterpreterIntegrity.
		 self assert: coInterpreter checkStackIntegrity.
		 self assert: (coInterpreter checkCodeIntegrity: fullGCFlag).
		 self validate "simulation only"]