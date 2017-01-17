source directories
platformRootDirectory
	"return the directory where we should find all platform's sources"
	(FileDirectory default
			directoryExists: (platformRootDirName
					ifNil: [self class platformsDirName]))
		ifFalse: ["The supposed directory for the platforms code does not  
			exist."
			^ self couldNotFindDirectory: 'the platform code tree'].
	^ FileDirectory default
		directoryNamed: (platformRootDirName
				ifNil: [self class platformsDirName])