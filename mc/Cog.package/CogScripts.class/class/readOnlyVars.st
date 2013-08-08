separate vm scripts
readOnlyVars
	^#(#checkForLeaks #fullGCLock #gcStartUsecs #memoryLimit #scavengeThreshold #youngStart
		#statCompMoveCount #statFullGCUsecs #statFullGCs #statGCEndUsecs #statGrowMemory #statIGCDeltaUsecs
		#statIncrGCUsecs #statIncrGCs #statMarkCount #statMkFwdCount #statRootTableCount #statRootTableOverflows
		#statShrinkMemory #statSpecialMarkCount #statSurvivorCount #statSweepCount #statTenures)