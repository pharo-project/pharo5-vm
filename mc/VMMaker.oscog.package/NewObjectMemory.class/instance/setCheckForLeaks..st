debug support
setCheckForLeaks: integerFlags
	"0 = do nothing.
	 1 = check for leaks on fullGC.
	 2 = check for leaks on incrementalGC.
	 8 = check for leaks on become"
	checkForLeaks := integerFlags