accessing
machinesDirName
	^DirNames at: #machineType ifAbsent:[SmalltalkImage current platformName]