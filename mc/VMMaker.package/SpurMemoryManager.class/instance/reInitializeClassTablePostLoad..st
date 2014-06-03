class table
reInitializeClassTablePostLoad: hiddenRoots
	self hiddenRootsObj: hiddenRoots.
	self expungeDuplicateAndUnmarkedClasses: false