source directories
platformRootDirectoryName: aString
	"set the directory where we should find all platform's sources
	There really ought to be plausible sanity checks done here"

	platformRootDirName := aString.
	aString asFileReference isDirectory
		ifFalse: [ 
			self couldNotFindDirectory: aString.
			^ false ].
	self reinitializePluginsLists.
	^ true