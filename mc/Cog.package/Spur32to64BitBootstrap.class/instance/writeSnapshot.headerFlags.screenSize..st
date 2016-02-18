snapshot
writeSnapshot: imageFileName headerFlags: headerFlags screenSize: screenSizeInteger
	heap64
		checkFreeSpace;
		runLeakCheckerForFullGC.
	interpreter64
		setImageHeaderFlagsFrom: headerFlags;
		setDisplayForm: nil;
		setSavedWindowSize: savedWindowSize;
		imageName: imageFileName;
		writeImageFileIO.
	Transcript cr; show: 'Done!'