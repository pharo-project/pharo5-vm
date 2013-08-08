build script
generateBuildScript

	(FileStream forceNewFileNamed: (self buildDir / 'build.sh') fullName) nextPutAll: (config fixLineEndsOf: config buildScript); close.
	