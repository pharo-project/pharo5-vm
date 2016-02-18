source generation
validateSourcesPresent
	| sources |
	sources := PharoFilesOpener default 
		openSources: SmalltalkImage current sourcesName 
		forImage: SmalltalkImage current imagePath.
	
	((sources == nil or: [sources atEnd])
			and: [ SmalltalkImage current checkSourcesFileAvailability])
		ifTrue: [
		self error: 'VM source code cannot be generated without .sources file'.
	]		