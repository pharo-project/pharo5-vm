cmake commands
addExternalLibraries: libs

	libs do: [:each | self addExternalLibrary: each ]