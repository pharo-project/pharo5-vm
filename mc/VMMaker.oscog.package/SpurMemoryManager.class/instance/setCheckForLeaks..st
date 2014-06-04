spur bootstrap
setCheckForLeaks: anInteger
	" 0 = do nothing.
	  1 = check for leaks on fullGC.
	  2 = check for leaks on scavenger.
	  4 = check for leaks on become
	  8 = check for leaks on truly incremental.
	15 = check for leaks on all four."
	checkForLeaks := anInteger