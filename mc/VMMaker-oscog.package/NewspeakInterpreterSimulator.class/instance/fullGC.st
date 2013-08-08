debug support
fullGC
	transcript cr; show:'<Running full GC ...'.
	super fullGC.
	transcript show: ' done>'.