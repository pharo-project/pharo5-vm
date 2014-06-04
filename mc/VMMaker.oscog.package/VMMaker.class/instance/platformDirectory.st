source directories
platformDirectory
	"return the directory where we should find the platform specific sources"
	| fd platNm |
	fd := self platformRootDirectory asFileReference.
	(fd / (platNm := self platformName)) exists
		ifFalse: ["The supposed directory for the actual platform code  
			does not exist."
			^ self couldNotFindPlatformDirectoryFor: platNm].
	^ fd / platNm