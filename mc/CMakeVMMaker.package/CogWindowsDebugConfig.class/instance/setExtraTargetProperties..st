as yet unclassified
setExtraTargetProperties: maker

	maker addExternalLibraries: self externalLibraries.
	maker set: 'EXECUTABLE_OUTPUT_PATH' toString: '${outputDir}'.

