simulation
runLeakChecker
	<doNotGenerate>
	| oldCheckForLeaks |
	oldCheckForLeaks := objectMemory checkForLeaks.
	objectMemory setCheckForLeaks: -1.
	[objectMemory runLeakCheckerFor: GCModeIncremental]
		ensure:
			[objectMemory setCheckForLeaks: oldCheckForLeaks]