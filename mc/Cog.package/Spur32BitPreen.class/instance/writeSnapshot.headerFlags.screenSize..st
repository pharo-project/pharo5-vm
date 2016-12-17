snapshot
writeSnapshot: imageFileName headerFlags: headerFlags screenSize: screenSizeInteger
	newHeap
		checkFreeSpace;
		runLeakCheckerForFullGC.
	newInterpreter
		setImageHeaderFlagsFrom: headerFlags;
		setDisplayForm: nil;
		setSavedWindowSize: savedWindowSize;
		imageName: imageFileName;
		writeImageFileIO.
	Transcript cr; show: 'Done!'