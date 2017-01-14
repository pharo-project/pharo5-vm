spur bootstrap
setCheckForLeaks: integerFlags
	" 0 = do nothing.
	  1 = check for leaks on fullGC (GCModeFull).
	  2 = check for leaks on scavenger (GCModeNewSpace).
	  4 = check for leaks on incremental (GCModeIncremental)
	  8 = check for leaks on become
	 16 = check for leaks on image segments"
	checkForLeaks := integerFlags