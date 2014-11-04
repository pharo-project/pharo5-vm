gmake commands
addSubdirectory: aDir
	Halt now.
	^ self include: ('$(TOP_PATH)/build/', aDir, '/', self outputFileName).
