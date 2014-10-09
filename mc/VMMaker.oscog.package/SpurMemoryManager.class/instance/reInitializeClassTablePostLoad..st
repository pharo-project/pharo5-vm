class table
reInitializeClassTablePostLoad: hiddenRoots
	self setHiddenRootsObj: hiddenRoots.
	self expungeDuplicateAndUnmarkedClasses: false