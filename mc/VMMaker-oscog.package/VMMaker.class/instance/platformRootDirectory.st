source directories
platformRootDirectory
	"return the directory where we should find all platform's sources"

	(platformRootDirName ifNil: [ self class platformsDirName ]) asFileReference isDirectory
		ifFalse: [ 
			"The supposed directory for the platforms code does not  
			exist."
			^ self couldNotFindDirectory: 'the platform code tree' ].
	^ (platformRootDirName ifNil: [ self class platformsDirName ]) fullName