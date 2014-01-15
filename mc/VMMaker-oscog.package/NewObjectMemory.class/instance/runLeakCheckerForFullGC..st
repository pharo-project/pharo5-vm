garbage collection
runLeakCheckerForFullGC: fullGCFlag
	<inline: false>
	(fullGCFlag
			ifTrue: [self leakCheckFullGC]
			ifFalse: [self leakCheckIncrementalGC]) ifTrue:
		[fullGCFlag
			ifTrue: [self reverseDisplayFrom: 0 to: 7]
			ifFalse: [self reverseDisplayFrom: 8 to: 15].
		 self clearLeakMapAndMapAccessibleObjects.
		 self assert: self checkHeapIntegrity.
		 self assert: self checkInterpreterIntegrity.
		 self assert: self checkStackIntegrity.
		 self assert: (self checkCodeIntegrity: fullGCFlag).
		 self validate "simulation only"]