private
checkForLeaksIn: om
	om setCheckForLeaks: GCModeFreeSpace + GCModeFull;
		runLeakCheckerFor: GCModeFull;
		checkFreeSpace: GCModeFull