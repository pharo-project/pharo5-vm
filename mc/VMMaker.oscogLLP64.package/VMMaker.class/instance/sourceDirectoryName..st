target directories
sourceDirectoryName: aString
	"Sanity check really ought to be added, This is the root directory for where the sources will be WRITTEN"
	sourceDirName := aString.
	(aString first == $.
		ifTrue: [FileDirectory default directoryNamed: aString]
		ifFalse: [FileDirectory on: aString]) assureExistence.
	self changed: #sourceDirectory.
	^true