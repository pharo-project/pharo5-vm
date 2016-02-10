gmake commands
addSubdirectory: aDir
	^ self include: ('$(TOP_PATH)/build/', aDir, '/', self outputFileName).
