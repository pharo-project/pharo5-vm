target directories
platformDirectories
	| root |
	^((root := self platformRootDirectory) directoryNames
		reject: [:dirName|
				dirName first = $. ".svn .git et al"
				or: [dirName ='CVS']])
		collect: [:dirName|
				root directoryNamed: dirName]