settings
readDocumentAtStartup
	^ ReadDocumentAtStartup ifNil: [ReadDocumentAtStartup := true]