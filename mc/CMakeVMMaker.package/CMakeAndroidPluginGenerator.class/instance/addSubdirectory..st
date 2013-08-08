gmake commands
addSubdirectory: aDir

	^ self include: ('$(buildDir)/', aDir, '/', self outputFileName).
