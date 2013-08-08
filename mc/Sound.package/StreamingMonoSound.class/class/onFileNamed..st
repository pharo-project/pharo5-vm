instance creation
onFileNamed: fileName
	"Answer an instance of me for playing the file with the given name."

	| f |
	f := FileSystem workingDirectory readOnlyFileNamed: fileName.
	f ifNil: [^ self error: 'could not open ', fileName].
	^ self new initStream: f headerStart: 0
