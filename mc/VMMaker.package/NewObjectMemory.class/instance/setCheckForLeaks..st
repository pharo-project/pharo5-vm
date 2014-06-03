debug support
setCheckForLeaks: anInteger
	"0 = do nothing.
	 1 = check for leaks on fullGC.
	 2 = check for leaks on incrementalGC.
	 4 = check for leaks on become
	 7 = check for leaks on all three."
	checkForLeaks := anInteger