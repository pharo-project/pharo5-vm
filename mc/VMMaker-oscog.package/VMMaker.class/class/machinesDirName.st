accessing
machinesDirName
	^DirNames at: #machineType ifAbsent:[Smalltalk os platformName]