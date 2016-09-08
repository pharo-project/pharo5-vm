path access
findPlatformsPathFrom: fd informing: bar
	| dirNames possiblePath |
	bar value: 'Searching in ', fd pathName.
	dirNames := fd directoryNames.
	(dirNames includes: 'platforms') ifTrue:[
		possiblePath := fd pathName, fd pathNameDelimiter asString, 'platforms'.
		(self confirm: 'Found a platforms directory at
', possiblePath,'
Do you want me to use it?') ifTrue:[^possiblePath].
	].
	dirNames do:[:dd|
		possiblePath := self findPlatformsPathFrom: (fd directoryNamed: dd) informing: bar.
		possiblePath ifNotNil:[^possiblePath].
	].
	^nil