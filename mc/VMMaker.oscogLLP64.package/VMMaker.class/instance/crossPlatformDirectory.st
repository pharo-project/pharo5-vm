source directories
crossPlatformDirectory
	"return the directory where we should find the cross-platform literal 
	sources - <sq.h> etc"
	| fd machDirNm |
	fd := self platformRootDirectory.
	(fd directoryExists: (machDirNm := 'Cross'))
		ifFalse: ["The supposed directory for the actual cross-platform code  
			does not exist."
			^ self couldNotFindPlatformDirectoryFor: 'cross-platform '].
	^ fd directoryNamed: machDirNm