source generation
validateSourcesPresent
	| sources |
	sources := Smalltalk openSources: SmalltalkImage current sourcesName forImage: SmalltalkImage current imageName.
	
	((sources == nil or: [sources atEnd])
			and: [ SmalltalkImage current checkSourcesFileAvailability])
		ifTrue: [
		self error: 'VM source code cannot be generated without .sources file'.
	]		